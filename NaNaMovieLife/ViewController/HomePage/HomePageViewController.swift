//
//  HomePageViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/24.
//

import UIKit

class HomePageViewController: BaseViewController {

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
    
    @IBAction func goUpcomingVC(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "\(UpcomingMovieTableViewController.self)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        UserDefaults.standard.removeObject(forKey: "favorite")
        print(NSHomeDirectory())
        if let favoriteMovies = MovieManager.loadFavoriteMoviesFromUserDefault() {
            MovieManager.favoriteMovies = favoriteMovies
            print("讀檔成功,我的收藏：\(MovieManager.favoriteMovies)")
        } else {
            print("讀檔失敗")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
