//
//  MovieListViewModel.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import Foundation

protocol MovieListViewModelDelegate: class {
    func didReceiveMovies()
    func didReceiveError(error: Error)
}

class MovieListViewModel {
    // MARK: - Properties
    private let moviesAPI: MovieService
    weak var delegate: MovieListViewModelDelegate?
    private(set) var movies: [Movie] = []
    
    // MARK: - Initialization
    init(movies: [Movie]? = nil) {
        if let inputMovies = movies {
            self.movies = inputMovies
        }
        
        self.moviesAPI = MovieService()
    }
}

// MARK: - Fetch and Search Methods
extension MovieListViewModel {
    func fetchTrendingMovies() {
        moviesAPI.fetchTrendingMovies(completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                self?.handleError(error: error)
                
            case .success(let receivedMovies):
                self?.handleSuccess(with: receivedMovies)
            }
        })
    }
    
    func searchMovieByName(_ searchText: String) {
        moviesAPI.searchMovieByName(search: searchText, completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                self?.handleError(error: error)
                
            case .success(let receivedMovies):
                self?.handleSuccess(with: receivedMovies)
            }
        })
    }
}

// MARK: - Handle Erros and Success
extension MovieListViewModel {
    private func handleSuccess(with movies: [Movie]) {
        self.movies = movies
        delegate?.didReceiveMovies()
    }
    
    private func handleError(error: Error) {
        delegate?.didReceiveError(error: error)
    }
}
