//
//  PopularList.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/16.
//

import UIKit

struct PopularList: Codable {
    
    var results: [PopularListInfo]
}
struct PopularListInfo: Codable {
    
    var title: String
    var overview: String
    var posterPath: String
    var id: Int
    
    // custom var
    var isFavorite: Bool = false
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case id
    }
}

extension PopularListInfo: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
