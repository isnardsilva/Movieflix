//
//  NetworkManagerMock.swift
//  MovieflixUnitTests
//
//  Created by Isnard Silva on 11/11/20.
//

import Foundation
@testable import Movieflix

class NetworkManagerMock: NetworkManagerProtocol {
    enum BundleError: Error {
        case failedLoad
        case invalidContent
    }
    
    
    func get(baseURL: String, parameters: [String : String]?, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        
        let bundle = Bundle(for: type(of: self))
        
        
        
        guard let url = bundle.path(forResource: "data", ofType: "json") else {
            completionHandler(.failure(BundleError.failedLoad))
            return
        }

        guard let data = NSData(contentsOfFile: url) else {
            completionHandler(.failure(BundleError.invalidContent))
            return
        }
        
        completionHandler(.success(data as Data))
    }
    
    
}
