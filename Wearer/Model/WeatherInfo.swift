//
//  WeatherInfo.swift
//  Wearer
//
//  Created by Nunzio Ricci on 16/01/23.
//

import Foundation

struct WeatherInfo {
    var position: Position?
    var time: Date
    var temperature: Double
    var humidity: Double
    var windspeed: Double
}
struct Position {
    var latitude: Double
    var longitude: Double
}
