//
//  MovieListsTableViewController.swift
//  NaNaMovie
//
//  Created by DaiDai on 2021/5/13.
//

import UIKit
import SDWebImage
import SVProgressHUD


// Object 不要放在 controller 裏面
//struct PopularList: Codable {
//
//    var results: [PopularListInfo]
//}
//struct PopularListInfo: Codable {
//
//    var title: String
//    var overview: String
//}




class MovieListsTableViewController: BaseTableViewController {
    
    @IBOutlet var tabelView: UITableView!
    var popularListArray = [PopularListInfo]()
    var nowPage = 1
    var totalPage: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "背景圖"))
        self.tableView.backgroundView?.alpha = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.popularListArray = []
        getMoviePopularList(page: 1)
        
    }
    
    // MARK: Private methods
    /// 取得熱門電影列表
    private func getMoviePopularList(page: Int) {
       
        SVProgressHUD.show(withStatus: "載入中")
        // 將打api以及解析包進去 ApiWebService
        ApiWebService().fetchPopularList(page: page) { [weak self] popularListResponse, totalPageResponse, error in
            
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            if let list = popularListResponse {
                
                for popularListInfoResponse in list {
                    let popularListInfo = PopularListInfo(with: popularListInfoResponse)
                    self.popularListArray.append(popularListInfo)
                }
//                self.popularListArray = list
                // 更新isFavorite
                self.updateIsFavorite()
                self.tableView.reloadData()
                self.totalPage = totalPageResponse
            } else {
                // show alert
            }
        }
        
        
//        let urlStr = "https://api.themoviedb.org/3/movie/popular?api_key=b3098921d68ce1f6040aec1402793262&language=zh-TW&page=1"
//        if let url = URL(string: urlStr) {
//
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//                if let data = data {
//
//                    do {
//
//                        let movieListData = try decoder.decode(PopularList.self, from: data)
//                        self.popularListArray = movieListData.results
//                        DispatchQueue.main.async {
//
//                            self.tableView.reloadData()
//                        }
//                    } catch {
//                        print("error")
//                    }
//                }
//            }.resume()
//        }
    }
    
    /// 更新我的最愛狀態
    private func updateIsFavorite() {
        
        print("[Dai]MovieManager.favoriteMovies = \(MovieManager.favoriteMovies)")
        for (index, popularMovie) in popularListArray.enumerated() {
            if MovieManager.favoriteMovies.contains(popularMovie) {
                popularListArray[index].isFavorite = true
            }
        }
    }
    
    // MARK: Button Action
    
    @objc func otherButtonIsClicked(_ sender: UIButton) {
        print("Other Button: \(sender.tag) Is Clicked")
    }
    
//    @IBAction func otherButtonAction(_ sender: UIButton) {
//        print("Other Button: \(sender.tag) Action")
//    }
    @IBAction func goFavoritePage(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "\(FavoritesPageTableViewController.self)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension MovieListsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return popularListArray.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElementIndex = popularListArray.count - 1
        if indexPath.row == lastElementIndex {
            let nextPage = nowPage + 1
            
            guard let totalPage = totalPage else { return }
            print("totalPage = \(totalPage)")
            
            guard nextPage <= totalPage else { return }
            print("nextPage = \(nextPage)")
            
            getMoviePopularList(page: nextPage)
            nowPage = nextPage
        }
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 200, 0, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0

        UIView.animate(withDuration: 0.5){
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieListsTableViewCell
        
        
        let movie: PopularListInfo = popularListArray[indexPath.row]
        // way 1 基本 設定 => 沒有耦合，在controller上的程式碼很長
        cell.movieTitleLabel.text = movie.title
        cell.movieIntroductionLabel.text = movie.overview
        if let imageurl = URL(string: ApiWebService.kImageBaseUrl + movie.posterPath) {
            cell.movieImageView.sd_setImage(with: imageurl, completed: nil)
        }
        // 因為 cell 會 reuse，所以圖片url解包失敗也要把 movieImageView 設定成 nil
        else {
            cell.movieImageView = nil
        }
        
//        if let imageurl = URL(string: ApiWebService.kImageBaseUrl + movie.poster_path) {
//            cell.movieImageView.load(url: imageurl, completion: nil)
//        }
        
        cell.favoriteButton.isSelected = movie.isFavorite
        
        cell.moreAction = {
            
            print("moreAction: \(indexPath.row)")
            // 跳電影明細頁面
            NavigationManager.goDetailVC(id: movie.id, nav: self.navigationController)
            
        }
        cell.favoritesAction = { [weak self] in
            guard let self = self else { return }
            
            if movie.isFavorite { // 是我的最愛
                // 從我的最愛移除
                if let index = MovieManager.favoriteMovies.firstIndex(of: movie) {
                    
                    self.popularListArray[indexPath.row].isFavorite = false
                    MovieManager.favoriteMovies.remove(at: index)
                }
            } else { // 不是我的最愛
                // 加入我的最愛
                self.popularListArray[indexPath.row].isFavorite = true
                MovieManager.favoriteMovies.append(self.popularListArray[indexPath.row])
            }
            print("[NaNa]\(MovieManager.favoriteMovies)")
            MovieManager.saveFavoriteMoviesToUserDefault()
        }
        
        // 替 other button 加上action
//        cell.otherButton.addTarget(self, action: #selector(otherButtonIsClicked(_:)), for: .touchUpInside)
//        cell.otherButton.tag = indexPath.row
        
        
//        // way 2 使用 model 設定 => 有耦合，但程式碼簡短
//        cell.cellConfiguration(popularListInfo: movie)
//
//        // way 3 使用 cell model 設定 => 解除耦合
//        let cellModel = MovieListCellModel(title: movie.title, introduction: movie.overview)
//        cell.cellConfiguration(cellModel: cellModel)
//
//        // way 4 使用 protocol 設定 => 解除耦合 只能用在 swift 上
//        cell.cellConfiguration(data: movie)

        return cell
    }
}


