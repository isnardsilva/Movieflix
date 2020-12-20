//
//  ServiceProtocol.swift
//  Movieflix
//
//  Created by Isnard Silva on 19/12/20.
//

import Foundation

protocol ServiceProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}
