//
//  MovieWebService.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/16.
//

import UIKit
import SVProgressHUD

extension ApiWebService {
    
    func fetchPopularList(page: Int, completionHandler: @escaping ([PopularListInfo]?, Error?) -> Void) {
        
        let urlStr = "\(ApiWebService.kPopularListUrl)?api_key=\(ApiWebService.kApiKey)&language=zh-TW&page=\(page)"
        if let url = URL(string: urlStr) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                
                DispatchQueue.main.async {
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    if let data = data {
                        
                        do {
                            
                            let movieListData = try decoder.decode(PopularList.self, from: data)
                            let popularListArray: [PopularListInfo] = movieListData.results
                            completionHandler(popularListArray, nil)
                            
                        } catch let error {
                            completionHandler(nil, error)
                        }
                    } else {
                        completionHandler(nil, error)
                    }
                    
                }
            }.resume()
        }
    }
}
