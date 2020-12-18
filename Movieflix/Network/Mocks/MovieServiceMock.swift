//
//  MovieServiceMock.swift
//  Movieflix
//
//  Created by Isnard Silva on 18/12/20.
//

import Foundation

class MovieServiceMock: NetworkManagerProtocol {
    
    func request<T: Decodable>(baseURL: String, parameters: [String: String]?, requestType: HTTPMethod, responseType: T.Type, completionHandler: (Result<T, Error>) -> Void) {
        
        let bundle = Bundle(for: type(of: self))
        
        // Check path
        guard let url = bundle.path(forResource: "movies", ofType: "json") else {
            completionHandler(.failure(BundleError.failedLoad))
            return
        }
        
        // Check content
        guard let data = NSData(contentsOfFile: url) as Data? else {
            completionHandler(.failure(BundleError.invalidContent))
            return
        }
        
        guard let decodedObject = try? JSONDecoder().decode(responseType, from: data) else {
            completionHandler(.failure(BundleError.objectNotDecoded))
            return
        }
        
        completionHandler(.success(decodedObject))
    }
}
