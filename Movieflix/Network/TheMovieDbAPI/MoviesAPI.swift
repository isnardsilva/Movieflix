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
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // MARK: - Fetch Methods
    func fetchTrendingMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
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
    
    func searchMovieByName(search: String, completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        let baseURL = TheMovieDbAPISources.baseURL
        let searchMoviesExtensionURL = TheMovieDbAPISources.searchMoviesExtensionURL
        
        let parameters: [String: String] = [
            TheMovieDbAPISources.ParameterName.query: search,
            TheMovieDbAPISources.ParameterName.APIKey: TheMovieDbAPISources.APIKey
        ]
        
        networkManager.get(baseURL: baseURL + searchMoviesExtensionURL, parameters: parameters, completionHandler: { result in
            
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
