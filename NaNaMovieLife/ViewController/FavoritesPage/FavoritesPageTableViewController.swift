//
//  FavoritesPageTableViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/25.
//

import UIKit
import SDWebImage

class FavoritesPageTableViewController: BaseTableViewController {

//    var dataArray: [FavoritesList] = MovieManager.likeMovies
    var favoriteList = MovieManager.favoriteMovies
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("[favoriteList] = \(MovieManager.favoriteMovies)")
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "背景圖"))
        self.tableView.backgroundView?.alpha = 0.5
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteList.count
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 300, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0

        UIView.animate(withDuration: 0.7){
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        // 建立 cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoritesPageTableViewCell else {
            return UITableViewCell()
        }
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
            NavigationManager.goDetailVC(id: favoriteList.id, nav: self.navigationController)
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
            MovieManager.saveFavoriteMoviesToUserDefault()
        }
        
        return cell
        
    }

}
