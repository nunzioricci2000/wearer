//
//  OMRequest.swift
//  Wearer
//
//  Created by Nunzio Ricci on 20/01/23.
//

import Foundation

struct OMRequest {
    static let url: URL = {
        let urlString = "https://api.open-meteo.com/v1/forecast"
        let url = URL(string: urlString)
        if let url = url {
            return url
        } else {
            fatalError("\"\(urlString)\" is not a valid URL!")
        }
    }()
    var latitude: Double
    var longitude: Double
    var hourly: [Hourly]?
    var currentWeather: Bool?
    var urlRequest: URLRequest {
        var request = URLRequest(url: Self.url)
        request.url?.append(queryItems: [
            .init(name: "latitude", value: String(latitude)),
            .init(name: "longitude", value: String(longitude))
        ])
        if let hourly = hourly {
            request.url?.append(queryItems: [
                .init(name: "hourly",
                      value: hourly.map({ $0.rawValue }).joined(separator: ","))
            ])
        }
        if let currentWeather = currentWeather {
            request.url?.append(queryItems: [
                .init(name: "current_weather", value: String(currentWeather))
            ])
        }
        return request
    }
}

extension OMRequest {
    enum Hourly: String {
    case temperature = "temperature_2m"
    case humidity = "relativehumidity_2m"
    case dewpoint = "dewpoint_2m"
    case weatherCode = "weathercode"
    }
}
