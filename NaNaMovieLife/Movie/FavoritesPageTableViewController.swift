//
//  FavoritesPageTableViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/25.
//

import UIKit
import SDWebImage

class FavoritesPageTableViewController: UITableViewController {

//    var dataArray: [FavoritesList] = MovieManager.likeMovies
    var favoriteList = MovieManager.favoriteMovies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[favoriteList] = \(MovieManager.favoriteMovies)")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        // 建立 cell
        // TODO: 這裡不能用 as!，如果不是 FavoritesPageTableViewCell 時會造成閃退 by 6/14
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoritesPageTableViewCell
        var favoriteList = favoriteList[indexPath.row]
        // set info for cell
        cell.movieTitle.text = favoriteList.title
        cell.movieInduction.text = favoriteList.overview
        if let imageurl = URL(string: ApiWebService.kImageBaseUrl + favoriteList.posterPath) {
            cell.movieImage.sd_setImage(with: imageurl, completed: nil)
        }
        cell.favoriteButton.isSelected = favoriteList.isFavorite
        cell.moreAction = {
            
            print("moreAction: \(indexPath.row)")
            // 跳電影明細頁面
            // TODO: 要把 goDetailVC 包到另一個 Class(Manager) 中，不能 new MovieListsTableViewController 來呼叫跳轉，程式邏輯不太合理
            MovieListsTableViewController().goDetailVC(id: favoriteList.id)
        }
        cell.favoritesAction = {
            
            if favoriteList.isFavorite { // 是我的最愛
                // 從我的最愛移除
                if let index = MovieManager.favoriteMovies.firstIndex(of: favoriteList) {
                    favoriteList.isFavorite = false
                    MovieManager.favoriteMovies.remove(at: index)
                }
            } else { // 不是我的最愛
                // 加入我的最愛
                favoriteList.isFavorite = true
                MovieManager.favoriteMovies.append(favoriteList)
            }
            print("[favorite]\(MovieManager.favoriteMovies)")
            // TODO: 要把 saveDataToUserDefault 包到另一個 Class(Manager) 中，不能 new HomePageViewController 來呼叫儲存，程式邏輯不太合理
            HomePageViewController().saveDataToUserDefault()
        }
        
        return cell
        
    }

}
