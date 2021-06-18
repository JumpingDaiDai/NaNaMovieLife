//
//  MovieDetailTableViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/2.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    var id: Int?
    var movieDetail: MovieDetail? {
        didSet{
            self.tableView.reloadData()
        }
    }
    var favoriteListInfo: [FavoriteListInfo] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    //呼叫電影詳細頁api
    func getMovieDetailList() {
        
        if let id = id {
            
            ApiWebService().fetchMovieDetails(id: id) { [weak self] movieDetail, error in
                
                guard let self = self else { return }
                
                if let detail = movieDetail {
                    self.movieDetail = detail
                } else {
                    // show alert
                }
            }
        }
    }
    
    //呼叫推薦列表api
    func getFavoriteListList() {
       
        if let id = id {
            ApiWebService().FatchFavoriteList(page: 1, id: id) { [weak self] FavoriteListInfo, error in
                
                guard let self = self else { return }
                
                if let list = FavoriteListInfo {
                    self.favoriteListInfo = list
                    print("[推薦api]\(list)")
                } else {
                    // show alert
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "背景圖"))
        self.tableView.backgroundView?.alpha = 0.5
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
            titleLabel.backgroundColor = .clear
            headerView.addSubview(titleLabel)
            return headerView
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieDetailTableViewCell else {
                return UITableViewCell()
            }
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
            
            guard let relatedCell = tableView.dequeueReusableCell(withIdentifier: "RelatedCell", for: indexPath) as? RelatedMovieTableViewCell else {
                return UITableViewCell()
            }
            
            relatedCell.favoriteListInfo = favoriteListInfo
            
            return relatedCell
            
        }
    }
}
