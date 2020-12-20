//
//  MovieServiceMock.swift
//  Movieflix
//
//  Created by Isnard Silva on 18/12/20.
//

import Foundation

class MovieServiceMock: NetworkManagerProtocol {
    
    func request<T: Decodable>(service: ServiceProtocol, responseType: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        let bundle = Bundle(for: type(of: self))
        
        // Check path
        guard let url = bundle.path(forResource: "movies", ofType: "json") else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // Check content
        guard let data = NSData(contentsOfFile: url) as Data? else {
            completionHandler(.failure(.invalidResponseType))
            return
        }
        
        guard let decodedObject = try? JSONDecoder().decode(responseType, from: data) else {
            completionHandler(.failure(.objectNotDecoded))
            return
        }
        
        completionHandler(.success(decodedObject))
    }
}
