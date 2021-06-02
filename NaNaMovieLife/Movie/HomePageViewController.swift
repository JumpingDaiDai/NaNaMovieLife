//
//  HomePageViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/24.
//

import UIKit

class HomePageViewController: UIViewController {

    var favoriteInfo = MovieManager.favoriteMovies
    @IBAction func goMovieListVC(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "\(MovieListsTableViewController.self)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goFavoriteVC(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "\(FavoritesPageTableViewController.self)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UserDefaults.standard.removeObject(forKey: "favorite")
        print(NSHomeDirectory())
        if let loadDataFromUserDefault = loadDataFromUserDefault() {
            MovieManager.favoriteMovies = loadDataFromUserDefault
            print("讀檔成功,我的收藏：\(MovieManager.favoriteMovies)")
        } else {
            print("讀檔失敗")
        }
    }
    
}

extension HomePageViewController {
    
    // 將資料存進user default
    func saveDataToUserDefault() {
        
        // 將 favoriteInfo encode
        guard let data = try? JSONEncoder().encode(favoriteInfo) else { return }
    
        // 將 favoriteInfo serialize
        if let array = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            print("array = \(array)")
            UserDefaults.standard.setValue(array, forKey: "favorite")
            
            print("bundle path: \(NSHomeDirectory())")
        }
        
        
        
    }
    
    // 將資料從user default讀出
    func loadDataFromUserDefault() -> [PopularListInfo]? {
        
        guard let array = UserDefaults.standard.value(forKey: "favorite") as? [[String: AnyObject]] else { return nil }
        
        var objects: [PopularListInfo] = [PopularListInfo]()
        for dict in array {
            
            // 將dictionary轉成 PopularListInfo
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return nil }
            guard let popularListInfo = try? JSONDecoder().decode(PopularListInfo.self, from: data) else { return nil }
            print("popularListInfo = \(popularListInfo)")
            objects.append(popularListInfo)
        }

        return objects
    }
}
