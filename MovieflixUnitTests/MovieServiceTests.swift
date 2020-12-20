//
//  MovieServiceTests.swift
//  MovieflixUnitTests
//
//  Created by Isnard Silva on 20/12/20.
//

import XCTest
@testable import Movieflix

class MovieServiceTests: XCTestCase {
    // MARK: - Properties
    var sut: MovieService!
    
    // MARK: - Test Methods
    override func setUp() {
        super.setUp()
        sut = MovieService(networkManager: MovieServiceMock())
    }
    
    func testFetchTrendingMovies() {
        // Given
        let promisse = expectation(description: "Fetch Trending Movies")
        var expectedMovies: [Movie]?
        
        // When
        sut.fetchTrendingMovies(completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                
            case .success(let movies):
                expectedMovies = movies
            }
            
            promisse.fulfill()
        })
        wait(for: [promisse], timeout: 5)
        
        // Then
        XCTAssertNotNil(expectedMovies)
        XCTAssertEqual(expectedMovies?.count, 20)
    }
    
    func testSearchMovie() {
        // Given
        let promisse = expectation(description: "Search Movie")
        var expectedMovies: [Movie]?
        
        // When
        sut.searchMovieByName(search: "Sponge Bob", completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                
            case .success(let movies):
                expectedMovies = movies
            }
            
            promisse.fulfill()
        })
        wait(for: [promisse], timeout: 5)
        
        // Then
        XCTAssertNotNil(expectedMovies)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
