//
//  RecommendList.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/9.
//

import Foundation

struct RecommendList: Codable {
    
    var results: [RecommendListInfo]
}

struct RecommendListInfo: Codable {
    
    var title: String
    var poster_path: String?
    var id: Int
}
