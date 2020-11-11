//
//  NetworkManagerTests.swift
//  MovieflixUnitTests
//
//  Created by Isnard Silva on 11/11/20.
//

import XCTest
@testable import Movieflix

class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    
    override func setUp() {
        sut = NetworkManager.shared
    }
    
    func testCallValidURL() {
        // Given
        let urlString = TheMovieDbAPISources.baseURL
        let trendingMoviesExtensionURL = TheMovieDbAPISources.trendingMoviesExtensionURL
        let apiKeyParameter = [TheMovieDbAPISources.ParameterName.APIKey: TheMovieDbAPISources.APIKey]
        let promise = expectation(description: "Completion handler to call a valid URL")
        var detectedError: Error?
        
        // When
        sut.get(baseURL: urlString + trendingMoviesExtensionURL, parameters: apiKeyParameter, completionHandler: { result in
            
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

        XCTAssertNil(detectedError, detectedError!.localizedDescription)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
