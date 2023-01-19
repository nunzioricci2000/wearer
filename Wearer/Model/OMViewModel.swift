//
//  OMViewModel.swift
//  Wearer
//
//  Created by Pietro Ciuci on 18/01/23.
//

import Foundation

class OMViewModel: ObservableObject {
    
    @Published var cityName: String = "Napoli"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = ""
    @Published var shouldShowLocationError: Bool = false
    
    let omService: OMService
    
    init(omService: OMService) {
        self.omService = omService
    }
    
    func refresh() {
        omService.loadWeatherData { weather, error in
            DispatchQueue.main.async {
                if let _ = error {
                    self.shouldShowLocationError = true
                    return
                }
                
                self.shouldShowLocationError = false
                guard let weather = weather else { return }
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)ºC"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = "icon" //iconMap[weather.iconName] ?? default icon
            }
        }
    }
    
}
