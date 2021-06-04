//
//  MovieWebService.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/16.
//

import UIKit
import SVProgressHUD

extension ApiWebService {
    
    // 取得熱門電影列表
    func fetchPopularList(page: Int, completionHandler: @escaping ([PopularListInfoResponse]?, Error?) -> Void) {
        
        let urlStr = "\(ApiWebService.kPopularListUrl)?api_key=\(ApiWebService.kApiKey)&language=zh-TW&page=\(page)"
        if let url = URL(string: urlStr) {
            
            // 呼叫 api
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    // http error
                    if error != nil {
                        
                        completionHandler(nil, error)
                    }
                    // 有打到server
                    else {
                        // 解碼
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        if let data = data {
                            
                            // 只是為了把 api response 印出來
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                print("Api url = \(urlStr) \n \(json)")
                            }
                            
                            do {
                                
                                let movieListData = try decoder.decode(PopularList.self, from: data)
                                let popularListArray: [PopularListInfoResponse] = movieListData.results
                                
                                // 執行 完成後要處理的closure，並塞入參數
                                completionHandler(popularListArray, nil)
                            }
                            // JSON decode 失敗
                            catch {
                                print("JSON decode 失敗: \(error)")
                                completionHandler(nil, error)
                            }
                        }
                        // api 回傳 data 是空的
                        else {
                            completionHandler(nil, error)
                        }
                    }
                    
                }
            }.resume()
        }
    }
    
    // 取得電影詳細資訊
    func fetchMovieDetails(id: Int, completionHandler: @escaping (MovieDetail?, Error?) -> Void) {
        
        let urlStr = "\(ApiWebService.kBaseUrl)/movie/\(id)?api_key=\(ApiWebService.kApiKey)&language=zh-TW"
        guard let url = URL(string: urlStr) else { return }
        
        
        print("\(url)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data {
                    
                    do {
                        let detalData = try decoder.decode(MovieDetail.self, from: data)
                        print(detalData)
                        
                        //MovieDetalsViewController().detalInfo(detalInfo: detalData)
                        completionHandler(detalData, nil)
                        
                    } catch {
                        print("error")
                    }
                }  else {
                    
                }
            }
        }.resume()
//        }
    }
}
