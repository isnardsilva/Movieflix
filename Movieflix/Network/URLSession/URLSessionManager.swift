//
//  URLSessionManager.swift
//  Movieflix
//
//  Created by Isnard Silva on 18/12/20.
//

import Foundation

class URLSessionManager: NetworkManagerProtocol {
    func request<T: Decodable>(service: ServiceProtocol, responseType: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        // Format URL
        guard let validURL = self.formatURL(serviceProtocol: service) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // Setup Request Type
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = service.method.rawValue
        
        // Run Request
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            // Check General Errors
            if let detectedError = error as NSError? {
                if detectedError.code == NSURLErrorDataNotAllowed {
                    completionHandler(.failure(.networkUnavailable))
                } else {
                    completionHandler(.failure(.unknowError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.connectionError))
                return
            }
            
            // Check response type
            guard let mimeType = response?.mimeType, mimeType == "application/json" else {
                completionHandler(.failure(.invalidResponseType))
                return
            }
            
            // Get Data
            guard let responseData = data,
                  let decodedObject = try? JSONDecoder().decode(T.self, from: responseData) else {
                completionHandler(.failure(.objectNotDecoded))
                return
            }
            
            completionHandler(.success(decodedObject))
        }).resume()
    }
    
//    func request<T: Decodable>(baseURL: String, parameters: [String: String]?, requestType: HTTPMethod, responseType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
//
//        // Format URL
//        guard let validURL = self.formatURL(baseURL: baseURL, parameters: parameters) else {
//            completionHandler(.failure(NetworkError.invalidURL))
//            return
//        }
//
//        // Setup Request Type
//        var urlRequest = URLRequest(url: validURL)
//        urlRequest.httpMethod = requestType.rawValue
//
//        // Run Request
//        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
//            // Check General Errors
//            if let detectedError = error as NSError? {
//                if detectedError.code == NSURLErrorDataNotAllowed {
//                    completionHandler(.failure(NetworkError.networkUnavailable))
//                } else {
//                    completionHandler(.failure(NetworkError.unknowError))
//                }
//                return
//            }
//
//            // Check response status code
//            guard let httpResponse = response as? HTTPURLResponse,
//                  httpResponse.statusCode == 200 else {
//                completionHandler(.failure(NetworkError.connectionError))
//                return
//            }
//
//            // Check response type
//            guard let mimeType = response?.mimeType, mimeType == "application/json" else {
//                completionHandler(.failure(NetworkError.invalidResponseType))
//                return
//            }
//
//            // Get Data
//            guard let responseData = data,
//                  let decodedObject = try? JSONDecoder().decode(T.self, from: responseData) else {
//                completionHandler(.failure(NetworkError.objectNotDecoded))
//                return
//            }
//
//            completionHandler(.success(decodedObject))
//        }).resume()
//    }
}

// MARK: - Setup URL
extension URLSessionManager {
    private func formatURL(serviceProtocol: ServiceProtocol) -> URL? {
        // Create URL
        guard var urlComponents = URLComponents(string: serviceProtocol.path) else {
            return nil
        }
        
        // Add Parameters
        if let receivedParameters = serviceProtocol.parameters {
            urlComponents.queryItems = []
            
            for parameter in receivedParameters {
                let queryItem = URLQueryItem(name: parameter.key, value: String(describing: parameter.value))
                urlComponents.queryItems?.append(queryItem)
            }
        }
        
        return urlComponents.url
    }
}
