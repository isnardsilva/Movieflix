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
    private let moviesAPI: MoviesAPI
    weak var delegate: MovieListViewModelDelegate?
    
    private(set) var movies: [Movie] = []
    
    var lastMovieNameSearched = String()
    
    // MARK: - Initialization
    init(movies: [Movie]? = nil) {
        if let inputMovies = movies {
            self.movies = inputMovies
        }
        
//        self.moviesAPI = MoviesAPI(networkManager: MovieServiceMock())
        self.moviesAPI = MoviesAPI()
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
    
    func searchMovieByName(_ movieName: String) {
        self.lastMovieNameSearched = movieName
        
        moviesAPI.searchMovieByName(search: movieName, completionHandler: { [weak self] result in
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
        delegate?.didReceiveMovies()
    }
    
    private func handleError(error: Error) {
        delegate?.didReceiveError(error: error)
    }
}
