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
    
    // MARK: 
    init(response: OMResponse) {
        city = ""
        temperature = "\(Int(response.currentWeather.temperature))"
        description = ""
        iconName = ""
    }
    
}
