//
//  APIResults.swift
//  Movieflix
//
//  Created by Isnard Silva on 07/11/20.
//

import Foundation

struct TheMovieDbAPIResults: Codable {
    let page: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
    }
}
