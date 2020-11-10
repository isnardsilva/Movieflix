//
//  MovieViewModel.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import Foundation

class MovieViewModel {
    // MARK: - Properties
    private let movie: Movie
    
    // MARK: - Get Properties
    var id: Int {
        return movie.id
    }
    
    var title: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview
    }
    
    var thumbnailPath: URL? {
        let urlString = TheMovieDbAPISources.thumbnailBaseURL + movie.posterPath
        return URL(string: urlString)
    }
    
    var backdropPath: URL? {
        let urlString = TheMovieDbAPISources.backdropBaseURL + movie.backdropPath
        return URL(string: urlString)
    }
    
    // MARK: - Initialization
    init(movie: Movie) {
        self.movie = movie
    }
}
