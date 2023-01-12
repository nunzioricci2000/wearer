//
//  TopWeather.swift
//  Wearer
//
//  Created by Pietro Ciuci on 12/01/23.
//

import SwiftUI

struct TopWeather: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Napoli")
                    Text("15°C")
                }
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                Spacer()
                Image(systemName: "cloud.sun.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            .padding(.horizontal, 25)
            HWeather()
            Text("Seems like it could rain today, don't forget your umbrella \(Image(systemName: "umbrella"))")
                .fixedSize(horizontal: false, vertical: true)

            .padding(.top)
            Spacer()
        }
    }
}

struct TopWeather_Previews: PreviewProvider {
    static var previews: some View {
        TopWeather()
    }
}
