//
//  WeatherInfo.swift
//  Wearer
//
//  Created by Alberto Mura on 31/01/23.
//

import SwiftUI

struct WeatherInfo: View {
    @State var response: OMResponse?
    
    var body: some View {
        GridRow {
            VStack {
                Text(locationName)
                Text(currentTemperature)
            }
            .gridCellColumns(2)
            .font(.system(size: 22, weight: .semibold, design: .rounded))
            Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                .gridCellColumns(1)
            Image(currentWeatherIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .font(.system(size: 26, weight: .light, design: .rounded))
                .gridCellColumns(3)
        }
        GridRow {
            ForEach(0..<6, id: \.self) { index in
                WeatherDetailView(time: time(for: index), iconName: iconName(for: index), temperature: temperature(for: index))
            }
        }
        GridRow {
            Text(currentWeatherDescription)
                .gridCellColumns(6)
                .padding(.vertical, 10)
        }
    }
}

extension WeatherInfo {
    var locationName: String {
        "Unknown location"
    }
    var currentTemperature: String {
        "..."
    }
    var currentWeatherIcon: String {
        ""
    }
    var currentWeatherDescription: String {
        "---"
    }
    
    func time(for index: Int) -> String {
        "___"
    }
    
    func iconName(for index: Int) -> String {
        "___"
    }
    
    func temperature(for index: Int) -> String {
        "___"
    }
}

private struct WeatherInfoPreview: View {
    @State var response: OMResponse?
    var body: some View {
        ZStack {
            if let response = response {
                WeatherInfo(response: response)
            }
        }.onAppear {
            Task {
                let coordinate = try? await LocationHandler.shared.getLocation()
                    .coordinate
                let coords = coordinate ?? .init(latitude: 50, longitude: 14)
                response = try? await OpenMeteo.shared.foreground(latitude: coords.latitude, longitude: coords.longitude)
            }
        }
    }
}

struct WeatherInfo_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoPreview()
    }
}
