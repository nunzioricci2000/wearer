//
//  OMViewModel.swift
//  Wearer
//
//  Created by Pietro Ciuci on 18/01/23.
//

import Foundation
import SwiftUI

@MainActor
class MainViewViewModel: ObservableObject {
    @Published var locationName: String?
    @Published var currentWeather: WeatherForegroud?
    @Published var currentWeatherDescription: String?
    @Published var foregrounds: [WeatherForegroud?] = .init(repeating: nil, count: 6)
    @Published var alert: ErrorAlert?
    var showAlert: Bool = false
    func refresh() async {
        do {
            locationName = try await LocationHandler.shared.getLocationName(of: LocationHandler.shared.getLocation())
            let coordinate = try await LocationHandler.shared.getLocation().coordinate
            let response = try await OpenMeteo.shared.forecast(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let currentWeatherForeround = OMForeground.from(code: response.currentWeather.weatherCode)
            currentWeatherDescription = currentWeatherForeround.weatherDescription
            currentWeather = .init(WeatherForegroud(temperature: "\(response.currentWeather.temperature)°C",
                                                    icon: currentWeatherForeround.weatherIcon))
            for index in foregrounds.indices {
                let index = (index+2) * 4
                let time = response.hourly.time[index]
                let temperature = response.hourly.temperature[index]
                let weatherCode = response.hourly.weatherCode[index]
                let foreground = OMForeground.from(code: weatherCode)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH"
                foregrounds[index / 4 - 2] = .init(time: dateFormatter.string(from: time),
                                           temperature: "\(temperature)°C",
                                           icon: foreground.weatherIcon)
            }
        } catch {
            switch error {
            case LocationError.nilLocation:
                presentGPSAlert()
            default:
                presentUnknownErrorAlert(error: error)
            }
            showAlert = true
        }
    }
    func presentGPSAlert() {
        alert = .init(title: "Location not found",
                      description: "Location not found, try to enable gps",
                      buttonText: "Open settings") {
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsURL)
            self.showAlert = false
        }
    }
    func presentUnknownErrorAlert(error: Error?) {
        print(error)
        alert = .init(title: "Unknown error",
                      description: error?.localizedDescription ?? "This error is really unknown!",
                      buttonText: error == nil ? "OH SHIT!" : "Close") {
            self.showAlert = false
        }
    }
}

struct WeatherForegroud {
    var time: String?
    var temperature: String?
    var icon: String?
}

struct ErrorAlert {
    var title: String
    var description: String
    var buttonText: String
    var onDismiss: () -> Void
    init(title: String, description: String, buttonText: String, onDismiss: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.buttonText = buttonText
        self.onDismiss = onDismiss
    }
}
