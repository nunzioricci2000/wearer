//
//  OMResponse.swift
//  Wearer
//
//  Created by Nunzio Ricci on 16/01/23.
//

import Foundation

// swiftlint:disable all

// Converting the weather code in the relative description and weather icon
struct OMForeground: Decodable {
    var weatherDescription: String
    var weatherIcon: String
    
    static func from(code: Int) -> Self {
        let foreground: Self
        switch code {
        case 0: foreground = .init(weatherDescription: "Clear sky",
                                   weatherIcon: "giorno.sereno")
        case 1, 2, 3: foreground = .init(weatherDescription: "Partly Cloudy",
                                         weatherIcon: "giorno.pnuvoloso")
        case 45, 48: foreground = .init(weatherDescription: "Fog",
                                        weatherIcon: "nebbia")
        case 51, 53, 55:foreground = .init(weatherDescription: "Drizzle",
                                           weatherIcon: "pioggia.debole")
        case 56, 57, 66, 67: foreground = .init(weatherDescription: "Hail",
                                                weatherIcon: "grandine")
        case 61, 63, 65: foreground = .init(weatherDescription: "Rain",
                                            weatherIcon: "pioggia")
        case 71, 73, 75, 77, 85, 86: foreground = .init(weatherDescription: "Snow",
                                                        weatherIcon: "neve")
        case 80, 81, 82: foreground = .init(weatherDescription: "Heavy Rain",
                                            weatherIcon: "pioggia.forte")
        case 95, 96, 99: foreground = .init(weatherDescription: "Thunderstorm",
                                            weatherIcon: "tempesta")
        default:
            fatalError("Codice non trovato!")
        }
        return foreground
    }
}

struct OMResponse: Decodable {
    var currentWeather: CurrentWeather
    var hourly: Hourly
    
    enum CodingKeys: String, CodingKey {
        case currentWeather = "current_weather"
        case hourly
    }
    
    struct Hourly: Decodable {
        var time: [String]
        var temperature: [Double]
        var weatherCode: [Int]
        
        enum CodingKeys: String, CodingKey {
            case time
            case temperature = "temperature_2m"
            case weatherCode = "weathercode"
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

/*var foregrounds: [OMForeground] {
 var foregrounds = [OMForeground]()
 for i in 0..<foregrounds.count {
 foregrounds.append(.init(time: hourly.time[i], temperature: hourly.temperature_2m[i]))
 }
 return foregrounds
 }*/

/*struct Position: Decodable {
 var latitude: Double
 var longitude: Double
 }*/
