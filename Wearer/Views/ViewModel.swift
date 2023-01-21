//
//  OMViewModel.swift
//  Wearer
//
//  Created by Pietro Ciuci on 18/01/23.
//

import Foundation
import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var locationName: String?
    @Published var currentWeather: WeatherForegroud?
    @Published var currentWeatherDescription: String?
    @Published var foregrounds: [WeatherForegroud?] = .init(repeating: nil, count: 6)
    @Published var alert: ErrorAlert?
    var showAlert: Bool {
        get {
            alert != nil
        }
        set {
            if !newValue {
                alert = nil
            }
        }
    }
    func refresh() async {
        do {
            locationName = try await LocationHandler.shared.getLocationName()
            let coordinate = try await LocationHandler.shared.getCoordinate()
            let request = OMRequest(latitude: coordinate.latitude,
                                    longitude: coordinate.longitude,
                                    hourly: [.temperature, .weatherCode],
                                    currentWeather: true)
            let response = try await OpenMeteo.shared.perform(request)
            let currentWeatherForeround = OMForeground.from(code: response.currentWeather.weatherCode)
            currentWeatherDescription = currentWeatherForeround.weatherDescription
            currentWeather = .init(WeatherForegroud(temperature: "\(response.currentWeather.temperature)°C",
                                                    icon: currentWeatherForeround.weatherIcon))
            for index in foregrounds.indices {
                let index = index
                let time = response.hourly.time[index]
                let temperature = response.hourly.temperature[index]
                let weatherCode = response.hourly.weatherCode[index]
                let foreground = OMForeground.from(code: weatherCode)
                foregrounds[index] = .init(time: time,
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
        }
    }
    func presentGPSAlert() {
        alert = .init(title: "Location not found",
                      description: "Location not found, try to enable gps",
                      buttonText: "Open settings") {
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsURL)
        }
    }
    func presentUnknownErrorAlert(error: Error?) {
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
