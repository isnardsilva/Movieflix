//
//  QueryService.swift
//  Movieflix
//
//  Created by Isnard Silva on 07/11/20.
//

import Foundation

class QueryService {
    // MARK: - Properties
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Type Alias
    typealias QueryResult = ([Movie]?, Error?) -> Void
    
    func getRequest(completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        if let urlComponents = URLComponents(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=3b6f1093e617eedbaa21c5937c0ae3b3") {
            
            // Verificando se a URL é valida
            guard let url = urlComponents.url else {
                print("Invalid URL")
                return
            }
            
            print(url)
            
            
            dataTask = defaultSession.dataTask(with: url, completionHandler: { [weak self] data, response, error in
                
                // Executando quando esse método (Closure) terminar
                defer {
                    self?.dataTask = nil
                }
                
                // Check if an error occured
                if error != nil {
                    // HERE you can manage the error
                    completion(nil, error)
                    return
                }
                
                // Serialize the data into an object
                do {
                    let json = try JSONDecoder().decode(APIResults.self, from: data!)
                    completion(json.results, nil)
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            })
            
            
            dataTask?.resume()
        }
    }
}
