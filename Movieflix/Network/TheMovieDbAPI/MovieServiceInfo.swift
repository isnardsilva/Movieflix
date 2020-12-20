//
//  MovieServiceInfo.swift
//  Movieflix
//
//  Created by Isnard Silva on 20/12/20.
//

import Foundation

enum MovieServiceInfo {
    case trendingMovies
    case searchMovie(query: String)
}

// MARK: - ServiceProtocol
extension MovieServiceInfo: ServiceProtocol {
    var path: String {
        switch self {
        case .trendingMovies:
            return makePath(route: TheMovieDbAPISources.trendingMoviesExtensionURL)
        
        case .searchMovie:
            return makePath(route: TheMovieDbAPISources.searchMoviesExtensionURL)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .trendingMovies,
             .searchMovie:
            return .GET
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .trendingMovies:
            return [
                TheMovieDbAPISources.ParameterName.APIKey: TheMovieDbAPISources.APIKey,
                TheMovieDbAPISources.ParameterName.language: DeviceInfo.shared.getLanguage()
            ]
        case .searchMovie(let query):
            return [
                TheMovieDbAPISources.ParameterName.APIKey: TheMovieDbAPISources.APIKey,
                TheMovieDbAPISources.ParameterName.language: DeviceInfo.shared.getLanguage(),
                TheMovieDbAPISources.ParameterName.query: query
            ]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    private func makePath(route: String) -> String {
        return TheMovieDbAPISources.baseURL + route
    }
}
