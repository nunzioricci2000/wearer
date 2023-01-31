//
//  OpenMeteo.swift
//  Wearer
//
//  Created by Nunzio Ricci on 19/01/23.
//

import Foundation

class OpenMeteo {
    static var shared = OpenMeteo()
    private init() {}
    var session = URLSession(configuration: .default)
    var decoder = JSONDecoder()
    func foreground(latitude: Double, longitude: Double) async throws -> OMResponse {
        let (data, _) = try await NetworkManager.shared.get(
            url: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,weathercode&current_weather=true")
        return try decoder.decode(OMResponse.self, from: data)
    }
}

enum OMError: Error {
    case nilDataInResponse
}
