//
//  APIResults.swift
//  Movieflix
//
//  Created by Isnard Silva on 07/11/20.
//

import Foundation

struct APIResults: Codable {
    let page: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
//        case userID = "userId"
        case page, results
    }
}
