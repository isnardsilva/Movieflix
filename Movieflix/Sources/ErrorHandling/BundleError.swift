//
//  BundleError.swift
//  Movieflix
//
//  Created by Isnard Silva on 18/12/20.
//

import Foundation

enum BundleError: Error {
    case failedLoad
    case invalidContent
    case objectNotDecoded
}

// MARK: - LocalizedError
extension BundleError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failedLoad:
            return "Não foi possível carregar o arquivo especificado."
        case .invalidContent:
            return "O conteúdo presente no arquivo especificado é inválido."
        case .objectNotDecoded:
            return "O objeto não pôde ser decodificado!"
        }
    }
}
