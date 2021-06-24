//
//  UpcomingMovie.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/18.
//

import Foundation

struct UpcomingMovieList: Codable {
    
    var results: [UpcomingListInfoResponse]
    var total_pages: Int
}

struct UpcomingListInfoResponse: Codable {
    
    var poster_path: String?
    var overview: String
    var release_date: String
    var id: Int
    var title: String
}

