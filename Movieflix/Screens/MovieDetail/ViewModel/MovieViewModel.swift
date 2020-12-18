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
        guard let strPosterPath = movie.posterPath else {
            return nil
        }
        let urlString = TheMovieDbAPISources.thumbnailBaseURL + strPosterPath
        return URL(string: urlString)
    }
    
    var backdropPath: URL? {
        guard let strBackdropPath = movie.backdropPath else {
            return nil
        }
        
        let urlString = TheMovieDbAPISources.backdropBaseURL + strBackdropPath
        return URL(string: urlString)
    }
    
    // MARK: - Initialization
    init(movie: Movie) {
        self.movie = movie
    }
}
