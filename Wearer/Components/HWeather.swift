//
//  HWeather.swift
//  Wearer
//
//  Created by Pietro Ciuci on 12/01/23.
//

import SwiftUI

struct HWeather: View {
    var icons: [Int] = [1, 2, 3, 4, 5, 6]
    var body: some View {
        HStack {
            ForEach(icons, id: \.self) { icon in
                HWeatherIcon()
            }
        }
    }
}

struct HWeather_Previews: PreviewProvider {
    static var previews: some View {
        HWeather()
    }
}

struct HWeatherIcon: View {
    var body: some View {
        VStack {
            Text("0-4") // hour
            Image(systemName: "moon") // SF Symbol icon
                .font(.system(size: 32, weight: .bold, design: .rounded))
            Text("4°C")
        }
        .font(.system(size: 12, weight: .regular, design: .rounded))
        .padding(.horizontal, 8)
    }
}
