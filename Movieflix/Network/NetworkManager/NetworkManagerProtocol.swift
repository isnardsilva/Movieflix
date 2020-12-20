//
//  NetworkManagerProtocol.swift
//  Movieflix
//
//  Created by Isnard Silva on 11/11/20.
//

import Foundation

/// Protocolo que especifica de que forma as framework de conexão entre o device e as API devem ser implementadas
protocol NetworkManagerProtocol {
    /// Realiza uma requisição para um url
    func request<T: Decodable>(service: ServiceProtocol, responseType: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}
