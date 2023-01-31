//
//  OMResponse.swift
//  Wearer
//
//  Created by Nunzio Ricci on 16/01/23.
//

import Foundation

struct OMResponse: Decodable {
    var currentWeather: CurrentWeather
    var hourly: Hourly
    enum CodingKeys: String, CodingKey {
        case currentWeather = "current_weather"
        case hourly
    }
    struct Hourly: Decodable {
        var time: [Date]
        var temperature: [Double]
        var weatherCode: [Int]
        enum CodingKeys: String, CodingKey {
            case time
            case temperature = "temperature_2m"
            case weatherCode = "weathercode"
        }
        init(from decoder: Decoder) throws {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            let container: KeyedDecodingContainer<OMResponse.Hourly.CodingKeys> = try decoder.container(keyedBy: OMResponse.Hourly.CodingKeys.self)
            self.time = try container.decode([String].self, forKey: OMResponse.Hourly.CodingKeys.time).map({ dateFormatter.date(from: $0)! })
            self.temperature = try container.decode([Double].self, forKey: OMResponse.Hourly.CodingKeys.temperature)
            self.weatherCode = try container.decode([Int].self, forKey: OMResponse.Hourly.CodingKeys.weatherCode)
        }
    }
    struct CurrentWeather: Decodable {
        var temperature: Double
        var weatherCode: Int
        enum CodingKeys: String, CodingKey {
            case temperature
            case weatherCode = "weathercode"
        }
    }
}
