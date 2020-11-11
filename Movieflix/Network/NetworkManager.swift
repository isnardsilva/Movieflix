//
//  NetworkManager.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import Foundation

class NetworkManager {
    // MARK: - Singleton
    static let shared: NetworkManager = NetworkManager()
    
    // MARK: - Properties
    enum HTTPError: Error {
        case notConnectedToInternet
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
        case unknown
    }
    
    // MARK: - Initialization
    private init() { }
    
    
    // MARK: - Internal Methods
    func get(baseURL: String, parameters: [String: String]?, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        
        
        // Format URL
        guard var urlComponents = URLComponents(string: baseURL) else {
            completionHandler(.failure(HTTPError.invalidURL))
            return
        }
        
        // Add Parameters
        if let receivedParameters = parameters, !receivedParameters.isEmpty {
            urlComponents.queryItems = []
            // Add Parameters
            for parameter in receivedParameters {
                let queryItem = URLQueryItem(name: parameter.key, value: parameter.value)
                urlComponents.queryItems?.append(queryItem)
            }
        }
        
        
        // Check URL
        guard let url = urlComponents.url else {
            completionHandler(.failure(HTTPError.invalidURL))
            return
        }
        
        
        // Request
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            // Check Errors
            if let detectedError = error as NSError? {
                // Check is without Internet
                if detectedError.code == NSURLErrorNotConnectedToInternet {
                    completionHandler(.failure(HTTPError.notConnectedToInternet))
                } else {
                    completionHandler(.failure(HTTPError.unknown))
                }
                
                return
            }
            
            // Handling the data
            guard let responseData = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                
                completionHandler(.failure(HTTPError.invalidResponse(data, response)))
                return
            }
            
            completionHandler(.success(responseData))
        })
        
        task.resume()
    }
}
