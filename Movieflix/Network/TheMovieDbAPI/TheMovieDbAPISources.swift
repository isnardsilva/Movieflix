//
//  TheMovieDbAPISources.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import Foundation

enum TheMovieDbAPISources {
    static let baseURL: String = "https://api.themoviedb.org/3"
    static let trendingMoviesExtensionURL = "/trending/movie/day"
    static let APIKey: String = "3b6f1093e617eedbaa21c5937c0ae3b3"
    
    enum ParameterName {
        static let APIKey = "api_key"
        static let limit = "limit"
    }
}