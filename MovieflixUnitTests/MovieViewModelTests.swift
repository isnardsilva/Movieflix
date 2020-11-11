//
//  MovieViewModelTests.swift
//  MovieflixUnitTests
//
//  Created by Isnard Silva on 11/11/20.
//

import XCTest
@testable import Movieflix

class MovieViewModelTests: XCTestCase {
    var sut: MovieViewModel!
    
    override func setUp() {
        super.setUp()
        
        let movieAPI = MoviesAPI(networkManager: NetworkManagerMock())
        movieAPI.fetchTrendingMovies(completionHandler: { [weak self] result in
            switch result {
            case .failure(_):
                break
            case .success(let movies):
                self?.sut = MovieViewModel(movie: movies.first!)
            }
        })
    }
    
    func testReturnValues() {
        /*
         let id: Int
         let title: String
         let voteAverage: Double
         let releaseDate: String
         let originalLanguage: String
         let originalTitle: String
         let adult: Bool
         let overview: String
         let backdropPath: String?
         let posterPath: String?
         */
        
        // Then
        XCTAssert(sut.id == 340102)
        XCTAssert(sut.title == "The New Mutants")
        XCTAssert(sut.overview == "Five young mutants, just discovering their abilities while held in a secret facility against their will, fight to escape their past sins and save themselves.")
        XCTAssert(sut.backdropPath?.absoluteString == TheMovieDbAPISources.backdropBaseURL + "/eCIvqa3QVCx6H09bdeOS8Al2Sqy.jpg")
        XCTAssert(sut.thumbnailPath?.absoluteString == TheMovieDbAPISources.thumbnailBaseURL + "/xrI4EnZWftpo1B7tTvlMUXVOikd.jpg")
    }
    
    override func tearDown() {
        super.setUp()
    }
}
