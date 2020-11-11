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
    static let APIKey: String = "<#Paste your API Key here#>"
    
    static let thumbnailBaseURL = "https://image.tmdb.org/t/p/w200"
    static let backdropBaseURL = "https://image.tmdb.org/t/p/w500"
    
    enum ParameterName {
        static let APIKey = "api_key"
        static let limit = "limit"
        static let query = "query"
    }
}
