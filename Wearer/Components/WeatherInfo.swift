//
//  WeatherInfo.swift
//  Wearer
//
//  Created by Alberto Mura on 31/01/23.
//

import SwiftUI

struct WeatherInfo: View {
    @State var response: OMResponse
    @StateObject var viewModel: ViewModel = .init()
    @Namespace var namespace
    var body: some View {
        GridRow {
            VStack {
                Text(viewModel.locationName ?? "Unknown location")
                Text(viewModel.currentWeather?.temperature ?? "...")
            }
            .gridCellColumns(2)
            .font(.system(size: 22, weight: .semibold, design: .rounded))
            Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                .gridCellColumns(1)
            Image(viewModel.currentWeather?.icon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .font(.system(size: 26, weight: .light, design: .rounded))
                .gridCellColumns(3)
        }
        GridRow {
            ForEach(viewModel.foregrounds, id: \.?.time) { foreground in
                weatherIcon(foreground ?? .init())
            }
        }
        GridRow {
            Text(viewModel.currentWeatherDescription ?? "...")
                .gridCellColumns(6)
                .padding(.vertical, 10)
        }
    }
}

func weatherIcon(_ foreground: WeatherForegroud) -> some View {
    VStack {
        Text(foreground.time ?? "--") // hour
        Image(foreground.icon ?? "") // SF Symbol icon
            .resizable()
            .scaledToFit()
            .frame(width: 26, height: 26)
        Text(foreground.temperature ?? "--")
    }
    .font(.system(size: 12, weight: .regular, design: .rounded))
    .padding(.horizontal, 8)
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
