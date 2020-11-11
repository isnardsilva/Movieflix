//
//  MovieServiceTests.swift
//  MovieflixUnitTests
//
//  Created by Isnard Silva on 11/11/20.
//

import XCTest
@testable import Movieflix

class MovieServiceTests: XCTestCase {
    var sut: MoviesAPI!
    
    override func setUp() {
        super.setUp()
        sut = MoviesAPI()
    }
    
    func testFetchTrendingMovies() {
        // Given
        let promise = expectation(description: "Completion handler to fetch movies")
        var detectedError: Error?
        
        
        // When
        sut.fetchTrendingMovies(completionHandler: { result in
            switch result {
            case .failure(let error):
                detectedError = error
            case .success(_):
                break
            }
            
            promise.fulfill()
        })
        
        // Then
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(detectedError)
    }
    
    func testSearchMovie() {
        // Given
        let promise = expectation(description: "Completion handler to search a movie")
        var detectedError: Error?
        
        // When
        sut.searchMovieByName(search: "It", completionHandler: { result in
            switch result {
            case .failure(let error):
                detectedError = error
            case .success(_):
                break
            }
            
            promise.fulfill()
        })
        
        // Then
        wait(for: [promise], timeout: 5)
        XCTAssertNil(detectedError)
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
