//
//  MovieService.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import Foundation

class MovieService {
    // MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Initialization
    init(networkManager: NetworkManagerProtocol = URLSessionManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: - Fetch Methods
    func fetchTrendingMovies(page: Int, completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        let service = MovieServiceInfo.trendingMovies(page: page)
        
        networkManager.request(service: service, responseType: TheMovieDbAPIResponse.self, completionHandler: { result in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                
            case .success(let receivedResponse):
                completionHandler(.success(receivedResponse.movies))
            }
        })
        
    }
    
    func searchMovieByName(search: String, completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        let service = MovieServiceInfo.searchMovie(query: search)
        
        networkManager.request(service: service, responseType: TheMovieDbAPIResponse.self, completionHandler: { result in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                
            case .success(let receivedResponse):
                completionHandler(.success(receivedResponse.movies))
            }
        })
    }
}
