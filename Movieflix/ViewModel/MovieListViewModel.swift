//
//  MovieListViewModel.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import Foundation

protocol MovieListViewModelDelegate: class {
    func didReceiveBreaches()
    func didReceiveError()
}

class MovieListViewModel {
    // MARK: - Properties
    private let moviesAPI: MoviesAPI
    weak var delegate: MovieListViewModelDelegate?
    
    private(set) var movies: [Movie] = []
    
    
    // MARK: - Initialization
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.moviesAPI = MoviesAPI(networkManager: networkManager)
    }
}


// MARK: - Network
extension MovieListViewModel {
    func fetchTrendingMovies() {
        moviesAPI.fetchTrendingMovies(completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                self?.handleError(error: error)
                
            case .success(let receivedMovies):
                self?.handleSucess(with: receivedMovies)
            }
        })
    }
    
    private func handleSucess(with movies: [Movie]) {
        self.movies = movies
        delegate?.didReceiveBreaches()
    }
    
    private func handleError(error: Error) {
        delegate?.didReceiveError()
    }
}
