//
//  MovieDetail.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/19.
//

import Foundation

struct MovieDetail: Codable {
    
    var original_title: String
    var overview: String?
    var poster_path: String?
    var release_date: String
    var runtime: Int?
    var title: String
    var vote_average: Float
    var vote_count: Int
}
