//
//  MovieServiceTests.swift
//  MovieflixUnitTests
//
//  Created by Isnard Silva on 11/11/20.
//

import XCTest
@testable import Movieflix

class MovieServiceMockTests: XCTestCase {
    var sut: MoviesAPI!
    
    override func setUp() {
        super.setUp()
        
        let networkManager = NetworkManagerMock()
        sut = MoviesAPI(networkManager: networkManager)
    }
    
    func testFetchMovies() {
        // When
        sut.fetchTrendingMovies(completionHandler: { result in
            // Then
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let movies):
                XCTAssert(movies.count == 20)
            }
        })
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
