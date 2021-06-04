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
    
    func getMovieDetailList() {
        
        if let id = id {
            
            ApiWebService().fetchMovieDetails(id: id) { [weak self] movieDetail, error in
                
                guard let self = self else { return }
                
                if let detail = movieDetail {
                    self.movieDetail = detail
                    self.tableView.reloadData()
                    
                    
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
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
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
    }
}
