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
    
    
    var id: Int?
    
    // 將打api以及解析包進去 ApiWebService
    func getMovieDetailList() {
        
        if let id = id {
            
            ApiWebService().fetchMovieDetails(id: id) { [weak self] detalList, error in
                
                guard let self = self else { return }
                
                if let list = detalList {
                    self.detalInfo(detalInfo: list)
                    
                    
                } else {
                    // show alert
                }
            }
        }
        
//        guard let id = id else { return }
//        let urlStr = "\(ApiWebService.kBaseUrl)/movie/\(id)?api_key=\(ApiWebService.kApiKey)&language=zh-TW"
//        guard let url = URL(string: urlStr) else { return }
//
//        if let url = URL(string: urlStr) {
//
//        print("\(url)")
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            if let data = data {
//
//                do {
//
//                    let detalData = try decoder.decode(DetalsList.self, from: data)
//                    print(detalData)
//                    DispatchQueue.main.async {
//                        self.detalInfo(detalInfo: detalData)
//                    }
//
//
//                } catch {
//                    print("error")
//                }
//            }
//        }.resume()
////        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getMovieDetailList()
        
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
