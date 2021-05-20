//
//  MovieDetalsViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/18.
//

import UIKit

class MovieDetalsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var originalTitleLable: UILabel!
    @IBOutlet weak var releaseDataLable: UILabel!
    @IBOutlet weak var runtimeLable: UILabel!
    @IBOutlet weak var averageScoreLable: UILabel!
    @IBOutlet weak var commentCountLable: UILabel!
    @IBOutlet weak var overviewLable: UILabel!
    
    var detalListArray = [DetalsList]()
    var id = ""
    func getDetalInfo() {
        
        let urlStr = "https://api.themoviedb.org/3/movie/567189?api_key=b3098921d68ce1f6040aec1402793262&language=zh-TW"
        if let url = URL(string: urlStr) {
        
            URLSession.shared.dataTask(with: url) { (data, response, error) in
        
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data {
        
                    do {
        
                        let detalData = try decoder.decode(DetalsList.self, from: data)
                        
                        print(detalData)
                    } catch {
                        print("error")
                    }
                }
            }.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

}
