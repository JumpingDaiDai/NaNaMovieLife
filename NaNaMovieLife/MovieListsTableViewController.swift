//
//  MovieListsTableViewController.swift
//  NaNaMovie
//
//  Created by DaiDai on 2021/5/13.
//

import UIKit

struct PopularList: Codable {
    
    var title: String
    var overview: String
}

class MovieListsTableViewController: UITableViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    
    func getMoviePopularList() {
        
        let urlStr = "https://api.themoviedb.org/3/movie/popular?api_key=b3098921d68ce1f6040aec1402793262&language=zh-TW&page=1"
        if let url = URL(string: urlStr) {
            
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
}
