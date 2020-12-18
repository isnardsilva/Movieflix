//
//  MoviesAPI.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import Foundation

class MoviesAPI {
    // MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Initialization
    init(networkManager: NetworkManagerProtocol = URLSessionManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: - Fetch Methods
    func fetchTrendingMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        // Mount URL
        var baseURL = TheMovieDbAPISources.baseURL
        baseURL += TheMovieDbAPISources.trendingMoviesExtensionURL
        
        let parameters: [String: String] = [
            TheMovieDbAPISources.ParameterName.APIKey: TheMovieDbAPISources.APIKey
        ]
        
        // Run Request
        networkManager.request(baseURL: baseURL, parameters: parameters, requestType: HTTPMethod.GET, responseType: TheMovieDbAPIResults.self, completionHandler: { result in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let receivedResponse):
                completionHandler(.success(receivedResponse.movies))
            }
        })
    }
    
    func searchMovieByName(search: String, completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        
        // Mount URL
        var baseURL = TheMovieDbAPISources.baseURL
        baseURL += TheMovieDbAPISources.searchMoviesExtensionURL
        
        let parameters: [String: String] = [
            TheMovieDbAPISources.ParameterName.query: search,
            TheMovieDbAPISources.ParameterName.APIKey: TheMovieDbAPISources.APIKey
        ]
        
        // Run Request
        networkManager.request(baseURL: baseURL, parameters: parameters, requestType: HTTPMethod.GET, responseType: TheMovieDbAPIResults.self, completionHandler: { result in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let receivedResponse):
                completionHandler(.success(receivedResponse.movies))
            }
        })
    }
}
