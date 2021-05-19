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
    var poster_path: String
}
