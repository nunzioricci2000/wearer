//
//  Weather.swift
//  Wearer
//
//  Created by Pietro Ciuci on 18/01/23.
//

import Foundation

struct Weather {
    var city: String
    let temperature: String
    let description: String
    let iconName: String
    let response: OMResponse
    init(response: OMResponse) {
        self.response = response
        city = ""
        temperature = "\(Int(response.currentWeather.temperature))"
        let foreground = OMForeground.from(code: response.currentWeather.weatherCode)
        iconName = "\(foreground.weatherIcon)"
        description = "\(foreground.weatherDescription)"

    }
}
