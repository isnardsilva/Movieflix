//
//  URLSessionManagerTests.swift
//  MovieflixUnitTests
//
//  Created by Isnard Silva on 18/12/20.
//

import XCTest
@testable import Movieflix

final class URLSessionManagerTests: XCTestCase {
    // MARK: - Properties
    var sut: URLSessionManager!
    
    // MARK: - Test Methods
    override func setUp() {
        super.setUp()
        sut = URLSessionManager()
    }
    
    func testRequest() {
        // Given
        // When
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
