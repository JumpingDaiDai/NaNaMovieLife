//
//  MovieDetalsViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/18.
//

import UIKit
import SDWebImage

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
    
    // TODO: ID不能設定為0，有可能真的有這個ID
    var id: Int = 0
    func getDetalInfo() {
        
        let urlStr = "\(ApiWebService.kBaseUrl)/movie/\(id)?api_key=\(ApiWebService.kApiKey)&language=zh-TW"
        guard let url = URL(string: urlStr) else { return }
        
        
//        if let url = URL(string: urlStr) {
        
        print("\(url)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = data {
                
                do {
                    
                    let detalData = try decoder.decode(DetalsList.self, from: data)
                    print(detalData)
                    DispatchQueue.main.async {
                        self.detalInfo(detalInfo: detalData)
                    }
                    
                    
                } catch {
                    print("error")
                }
            }
        }.resume()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getDetalInfo()
        
    }
    
    func detalInfo(detalInfo: DetalsList) {
        
        titleLable.text = detalInfo.title
        originalTitleLable.text = detalInfo.original_title
        releaseDataLable.text = "上映時間：\(detalInfo.release_date)"
        if let runtime = detalInfo.runtime {
            runtimeLable.text = "片長：\(runtime)分"
        }
        averageScoreLable.text = "評分：\(detalInfo.vote_average) / 10"
        commentCountLable.text = "評分數量：\(detalInfo.vote_count)筆"
        overviewLable.text = detalInfo.overview
        guard let movieImage = detalInfo.poster_path else { return }
        if let imageurl = URL(string: ApiWebService.kImageBaseUrl + movieImage) {
            self.movieImage.sd_setImage(with: imageurl, completed: nil)
        }
    }
}
