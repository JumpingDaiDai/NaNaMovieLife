//
//  DetalsList.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/19.
//

import UIKit

struct DetalsList: Codable {
    
    var overview: String?
    var poster_path: String?
    var release_date: String
    var title: String
    var vote_average: Double
    var vote_count: Int
}
