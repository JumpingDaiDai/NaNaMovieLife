//
//  MovieWebService.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/16.
//

import UIKit
import SVProgressHUD

extension ApiWebService {
    
    //MARK: 取得熱門電影列表
    func fetchPopularList(page: Int, completionHandler: @escaping ([PopularListInfoResponse]?, _ totalPage: Int?, Error?) -> Void) {
        
        let urlStr = "\(ApiWebService.kPopularListUrl)?api_key=\(ApiWebService.kApiKey)&language=zh-TW&page=\(page)"
        if let url = URL(string: urlStr) {
            
            // 呼叫 api
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    // http error
                    if error != nil {
                        
                        completionHandler(nil, nil, error)
                    }
                    // 有打到server
                    else {
                        // 解碼
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        if let data = data {
                            
                            // 只是為了把 api response 印出來
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                print("Api url = \(urlStr) \n \(json.json)")
                            }
                            
                            do {
                                
                                let movieListData = try decoder.decode(PopularList.self, from: data)
                                let popularListArray: [PopularListInfoResponse] = movieListData.results
                                let totalPage = movieListData.total_pages
                                // 執行 完成後要處理的closure，並塞入參數
                                completionHandler(popularListArray, totalPage, nil)
                            }
                            // JSON decode 失敗
                            catch {
                                print("JSON decode 失敗: \(error)")
                                completionHandler(nil, nil, error)
                            }
                        }
                        // api 回傳 data 是空的
                        else {
                            completionHandler(nil, nil,error)
                        }
                    }
                    
                }
            }.resume()
        }
    }
    
    //MARK: 取得電影詳細資訊
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
    
    //MARK: 取得推薦電影列表
    func fetchRecommendList(page: Int, id: Int, completionHandler: @escaping ([RecommendListInfo]?, Error?) -> Void) {
        
        let urlStr = "\(ApiWebService.kBaseUrl)/movie/\(id)/recommendations?api_key=\(ApiWebService.kApiKey)&language=zh-TW&page=\(page)"
        guard let url = URL(string: urlStr) else { return }
        print("\(url)")
        //呼叫api
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                // http error
                if error != nil {
                    completionHandler(nil, error)
                }
                //有打到server
                else {
                    
                    //解碼
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    if let data = data {
                        
                        //印出api response
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Api url = \(urlStr) \n \(json)")
                        }
                        do {
                            
                            let recommendListData = try decoder.decode(RecommendList.self, from: data)
                            let recommendListArray: [RecommendListInfo] = recommendListData.results
                            
                            // 執行 完成後要處理的closure，並塞入參數
                            completionHandler(recommendListArray, nil)
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
    
    //MARK: 取得即將上映電影列表
    func fetchUpcomingMovieList(page: Int, region: String, completionHandler: @escaping ([UpcomingListInfoResponse]?, _ totalPage: Int?, Error?) -> Void) {
        
        let urlStr = "\(ApiWebService.kUpcomingUrl)?api_key=\(ApiWebService.kApiKey)&language=zh-TW&page=\(page)&region=\(region)"
        guard let url = URL(string: urlStr) else { return }
        print("\(url)")
        
        //呼叫api
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                //heep error
                if error != nil {
                    completionHandler(nil, nil, error)
                }
                //有打到server
                else {
                    //解碼
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    if let data = data {
                        
                        //印出api response
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Api url = \(urlStr) \n \(json)")
                        }
                        do {
                            let upcomingListData = try decoder.decode(UpcomingMovieList.self, from: data)
                            let upcomingListArray: [UpcomingListInfoResponse] = upcomingListData.results
                            let totalPage = upcomingListData.total_pages
                            // 執行 完成後要處理的closure，並塞入參數
                            completionHandler(upcomingListArray, totalPage, nil)
                            
                        }
                        // JSON decode 失敗
                        catch {
                            print("JSON decode 失敗: \(error)")
                            completionHandler(nil, nil, error)
                        }
                    }
                    // api 回傳 data 是空的
                    else {
                        completionHandler(nil, nil, error)
                    }
                }
            }
        }.resume()
    }
}
