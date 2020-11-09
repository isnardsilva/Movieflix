//
//  MoviesAPI.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import Foundation

class MoviesAPI {
    // MARK: - Properties
    private let networkManager: NetworkManager
    
    
    // MARK: - Initialization
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    
    // MARK: - Fetch Methods
    func fetchMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        let baseURL = TheMovieDbAPISources.baseURL
        let trendingMoviesExtensionURL = TheMovieDbAPISources.trendingMoviesExtensionURL
        
        let parameters: [String: String] = [
            TheMovieDbAPISources.ParameterName.APIKey: TheMovieDbAPISources.APIKey
        ]
        
        networkManager.get(baseURL: baseURL + trendingMoviesExtensionURL, parameters: parameters, completionHandler: { result in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(TheMovieDbAPIResults.self, from: data)
                    completionHandler(.success(results.movies))
                } catch {
                    completionHandler(.failure(error))
                }
            }
            
        })
    }
}
