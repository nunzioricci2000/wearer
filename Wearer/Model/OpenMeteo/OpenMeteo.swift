//
//  OpenMeteo.swift
//  Wearer
//
//  Created by Nunzio Ricci on 19/01/23.
//

import Foundation

class OpenMeteo {
    static var shared = OpenMeteo()
    var session = URLSession(configuration: .default)
    var decoder = JSONDecoder()
    func perform(_ request: OMRequest) async throws -> OMResponse {
        let (data, _) = try await session.data(for: request.urlRequest)
        return try decoder.decode(OMResponse.self, from: data)
    }
}

enum OMError: Error {
    case nilDataInResponse
}
