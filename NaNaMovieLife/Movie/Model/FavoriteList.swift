//
//  FavoriteList.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/9.
//

import Foundation

struct FavoriteList: Codable {
    
    var results: [FavoriteListInfo]
}

struct FavoriteListInfo: Codable {
    
    var title: String
    var poster_path: String?
    var id: Int
}
