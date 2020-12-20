//
//  URLSessionManagerTests.swift
//  MovieflixUnitTests
//
//  Created by Isnard Silva on 18/12/20.
//

import XCTest
@testable import Movieflix

class URLSessionManagerTests: XCTestCase {
    // MARK: - Properties
    var sut: URLSessionManager!
    
    // MARK: - Test Methods
    override func setUp() {
        super.setUp()
        sut = URLSessionManager()
    }
    
    func testRequestToAnAPI() {
        // Given
        let movieService = MovieServiceInfo.trendingMovies
        let promise = expectation(description: "Test request to an API")
        var responseError: Error?
        
        // When
        sut.request(service: movieService, responseType: TheMovieDbAPIResponse.self, completionHandler: { result in
            
            switch result {
            case .failure(let error):
                responseError = error
                
            case .success:
                break
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertNil(responseError)
    }
    
    func testRequestWithObjectNotDecodedError() {
        // Given
        let movieService = MovieServiceInfo.trendingMovies
        let promise = expectation(description: "Test Request WithObjectNotDecodedErrorI")
        let expectedError = NetworkError.objectNotDecoded
        var receivedError: NetworkError?
        
        // When
        sut.request(service: movieService, responseType: String.self, completionHandler: { result in
            switch result {
            case .failure(let error):
                receivedError = error
                
            case .success:
                break
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertEqual(receivedError, expectedError)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
