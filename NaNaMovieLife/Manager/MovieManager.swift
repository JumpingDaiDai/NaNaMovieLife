//
//  MovieManager.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/26.
//

import UIKit

class MovieManager: NSObject {
    
    private static var kFavorite = "favorite"
    
    static var favoriteMovies: [PopularListInfo] = []
    
    /// 將資料存進user default
    class func saveFavoriteMoviesToUserDefault() {
        
        // 將 favoriteInfo encode
        guard let data = try? JSONEncoder().encode(favoriteMovies) else { return }
        
        // 將 favoriteInfo serialize
        if let array = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            print("array = \(array)")
            UserDefaults.standard.setValue(array, forKey: kFavorite)
            
            print("bundle path: \(NSHomeDirectory())")
        }
    }
    
    /// 將資料從user default讀出
    class func loadFavoriteMoviesFromUserDefault() -> [PopularListInfo]? {
        
        guard let array = UserDefaults.standard.value(forKey: kFavorite) as? [[String: AnyObject]] else { return nil }
        
        var objects: [PopularListInfo] = [PopularListInfo]()
        for dict in array {
            // 將dictionary轉成 PopularListInfo
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return nil }
            guard let popularListInfo = try? JSONDecoder().decode(PopularListInfo.self, from: data) else { return nil }
            print("popularListInfo = \(popularListInfo)")
            objects.append(popularListInfo)
        }

        return objects
    }
}
