//
//  NetworManagerProtocol.swift
//  Movieflix
//
//  Created by Isnard Silva on 11/11/20.
//

import Foundation

protocol NetworkManagerProtocol {
    func get(baseURL: String, parameters: [String: String]?, completionHandler: @escaping (Result<Data, Error>) -> Void)
}
