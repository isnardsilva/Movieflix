//
//  TheMovieDbAPIResponse.swift
//  Movieflix
//
//  Created by Isnard Silva on 07/11/20.
//

import Foundation

struct TheMovieDbAPIResponse: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
