//
//  Dictionary+JSON.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/16.
//

import Foundation

extension Dictionary {

    var json: String {
        let errorJson = "JSON Format error "
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? errorJson
        } catch {
            return errorJson
        }
    }
}
