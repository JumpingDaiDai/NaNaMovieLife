//
//  MovieDetailTableViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/2.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    var id: Int?
    var movieDetail: MovieDetail?
    var favoriteListInfo: [FavoriteListInfo] = []
    //呼叫電影詳細頁api
    func getMovieDetailList() {
        
        // TODO: 這裡適合使用 guard let 來解包 by 6/14
        if let id = id {
            
            ApiWebService().fetchMovieDetails(id: id) { [weak self] movieDetail, error in
                
                guard let self = self else { return }
                
                if let detail = movieDetail {
                    self.movieDetail = detail
                    
                    // TODO: reload 可以寫在 movieDetail 的 didSet 中 by 6/14
                    self.tableView.reloadData()
                    
                    
                } else {
                    // show alert
                }
            }
        }
    }
    
    //呼叫推薦列表api
    func getFavoriteListList() {
       
        // 將打api以及解析包進去 ApiWebService
        // TODO: 這裡適合使用guard let 來解包 by 6/14
        if let id = id {
            ApiWebService().FatchFavoriteList(page: 1, id: id) { [weak self] FavoriteListInfo, error in
                
                guard let self = self else { return }
                
                // TODO: 拼錯 lise -> list by 6/14
                if let lise = FavoriteListInfo {
                    self.favoriteListInfo = lise
                    
                    // TODO: reload 可以寫在 favoriteListInfo 的 didSet 中 by 6/14
                    self.tableView.reloadData()
                    print("[推薦api]\(lise)")
                    
                } else {
                    // show alert
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMovieDetailList()
        getFavoriteListList()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 40
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: 0))
            return headerView
        } else {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: 0))
            let titleLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: tableView.bounds.size.width - 10, height: 40))
            titleLabel.text = "推薦電影"
            titleLabel.backgroundColor = .white
            headerView.addSubview(titleLabel)
            return headerView
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            // TODO: 這裡不能用 as!，如果不是 MovieDetailTableViewCell 時會造成閃退 by 6/14
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieDetailTableViewCell
            if let data: MovieDetail = movieDetail {
                if let url = data.poster_path {
                    
                    if let imageurl = URL(string: ApiWebService.kImageBaseUrl + url) {
                        cell.movieImage.sd_setImage(with: imageurl, completed: nil)
                    }
                }
                cell.titleLable.text = data.title
                cell.originalTitleLable.text = data.original_title
                cell.releaseDataLable.text = data.release_date
                if let runtimeLable = data.runtime {
                    cell.runtimeLable.text = "\(runtimeLable)"
                }
                cell.averageScoreLable.text = "\(data.vote_average)"
                cell.commentCountLable.text = "\(data.vote_count)"
                if let overview = data.overview {
                    cell.overviewLable.text = "\(overview)"
                    
                }
            }
            return cell
        } else {
            // TODO: 這裡不能用 as!，如果不是 RelatedMovieTableViewCell 時會造成閃退 by 6/14
            let relatedCell = tableView.dequeueReusableCell(withIdentifier: "RelatedCell", for: indexPath) as! RelatedMovieTableViewCell
            
            relatedCell.favoriteListInfo = favoriteListInfo
            
            return relatedCell
            
        }
    }
}
