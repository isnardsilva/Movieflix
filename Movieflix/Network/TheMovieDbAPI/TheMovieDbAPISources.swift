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
    static let searchMoviesExtensionURL = "/search/movie"
    static let APIKey: String = "3b6f1093e617eedbaa21c5937c0ae3b3"
    
    static let thumbnailBaseURL = "https://image.tmdb.org/t/p/w200"
    static let backdropBaseURL = "https://image.tmdb.org/t/p/w500"
    
    enum ParameterName {
        static let APIKey = "api_key"
        static let page = "page"
        static let language = "language"
        static let query = "query"
    }
}
