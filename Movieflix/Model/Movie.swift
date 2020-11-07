//
//  Movie.swift
//  Movieflix
//
//  Created by Isnard Silva on 06/11/20.
//

import Foundation

struct Movie: Codable {
    // MARK: - Properties
    let id: Int
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let originalLanguage: String
    let originalTitle: String
    let adult: Bool
    let overview: String
    let posterPath: String
    var favorite: Bool = false
    
    // MARK: - Parse
    enum CodingKeys: String, CodingKey {
        case id, title, adult, overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
    }
}
