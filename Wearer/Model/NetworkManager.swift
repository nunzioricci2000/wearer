//
//  NetworkManager.swift
//  Wearer
//
//  Created by Nunzio Ricci on 31/01/23.
//

import Foundation

/// This class provides a singleton for network menagement
class NetworkManager {
    static var shared = NetworkManager()
    private init () {}
    
    /// return a data from given link
    func get(url: String) async throws -> (Data, URLResponse) {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL(url: url) }
        let request = URLRequest(url: url)
        return try await URLSession.shared.data(for: request)
    }
}

enum NetworkError: Error {
    case invalidURL(url: String)
}
