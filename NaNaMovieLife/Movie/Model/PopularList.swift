//
//  PopularList.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/16.
//

import Foundation

struct PopularList: Codable {
    
    var results: [PopularListInfoResponse]
}

struct PopularListInfoResponse: Codable {
    var title: String
    var overview: String
    var posterPath: String
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case id
    }
}

extension PopularListInfo {
    
    init(with response: PopularListInfoResponse) {
        self.title = response.title
        self.overview = response.overview
        self.posterPath = response.posterPath
        self.id = response.id
    }
}

struct PopularListInfo: Codable {
    
    var title: String
    var overview: String
    var posterPath: String
    var id: Int
    var isFavorite: Bool = false
    
    // memberwise initializer
//    init(title: String, overview: String, posterPath: String, id: Int) {
//        self.title = title
//        self.overview = overview
//        self.posterPath = posterPath
//        self.id = id
//    }

    
    
    static func create(with response: PopularListInfoResponse) -> PopularListInfo {
        
        let info = PopularListInfo(title: response.title,
                                   overview: response.overview,
                                   posterPath: response.posterPath,
                                   id: response.id)
        
        return info
    }
    
//    static func create(with dictionary: [String: AnyObject]) -> PopularListInfo {
//
//        let info = PopularListInfo(title: dictionary["title"] as? String ?? "",
//                                   overview: dictionary["overview"] as? String ?? "",
//                                   posterPath: dictionary["posterPath"] as? String ?? "",
//                                   id: dictionary["id"] as? Int ?? -1)
//
//        return info
//    }
}


extension PopularListInfo: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
