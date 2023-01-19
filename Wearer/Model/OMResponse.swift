//
//  OMResponse.swift
//  Wearer
//
//  Created by Nunzio Ricci on 16/01/23.
//

import Foundation

// swiftlint:disable all

struct OMHourly: Decodable {
    var time: [String]
    var temperature_2m: [Double]
}

/*struct OMHourlyUnits: Decodable {
    var time: String
    var temperature_2m: String
}*/

struct OMForeground: Decodable {
    var time: String
    var temperature: Double
}

struct OMCurrentWeather: Decodable {
    var temperature: Double
    var weatherCode: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature
        case weatherCode = "weathercode"
    }
}

struct OMResponse: Decodable {
    var currentWeather: OMCurrentWeather
    //var hourly: OMHourly
    
    
    enum CodingKeys: String, CodingKey {
        case currentWeather = "current_weather"
        //case hourly
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
