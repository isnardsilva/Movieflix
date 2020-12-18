//
//  URLSessionManager.swift
//  Movieflix
//
//  Created by Isnard Silva on 18/12/20.
//

import Foundation

class URLSessionManager: NetworkManagerProtocol {
    func request<T: Decodable>(baseURL: String, parameters: [String: String]?, requestType: HTTPMethod, responseType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        // Format URL
        guard let validURL = self.formatURL(baseURL: baseURL, parameters: parameters) else {
            completionHandler(.failure(NetworkError.invalidURL))
            return
        }
        
        // Setup Request Type
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = requestType.rawValue
        
        // Run Request
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // Check General Errors
            if let detectedError = error as NSError? {
                if detectedError.code == NSURLErrorDataNotAllowed {
                    completionHandler(.failure(NetworkError.networkUnavailable))
                } else {
                    completionHandler(.failure(NetworkError.unknowError))
                }
                return
            }
            
            // Check response status code
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completionHandler(.failure(NetworkError.connectionError))
                return
            }
            
            // Check response type
            guard let mimeType = response?.mimeType, mimeType == "application/json" else {
                completionHandler(.failure(NetworkError.invalidResponseType))
                return
            }
            
            // Get Data
            guard let responseData = data,
                  let decodedObject = try? JSONDecoder().decode(T.self, from: responseData) else {
                completionHandler(.failure(NetworkError.objectNotDecoded))
                return
            }
            
            completionHandler(.success(decodedObject))
        }).resume()
    }
}

// MARK: - Setup URL
extension URLSessionManager {
    private func formatURL(baseURL: String, parameters: [String: String]?) -> URL? {
        // Format URL
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        
        // Add parameters
        if let receivedParameters = parameters {
            urlComponents.queryItems = []
            
            for parameter in receivedParameters {
                let queryItem = URLQueryItem(name: parameter.key, value: parameter.value)
                urlComponents.queryItems?.append(queryItem)
            }
        }
        
        return urlComponents.url
    }
}
