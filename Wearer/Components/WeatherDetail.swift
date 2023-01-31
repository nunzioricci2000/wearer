//
//  WeatherDetailView.swift
//  Wearer
//
//  Created by Francesco De Simone on 31/01/23.
//

import SwiftUI

struct WeatherDetailView: View {
    @State var time: String
    @State var iconName: String
    @State var temperature: String
    
    var body: some View {
        VStack {
            Text(time) // hour
            Image(iconName) // SF Symbol icon
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
            Text(temperature)
        }
        .font(.system(size: 12, weight: .regular, design: .rounded))
        .padding(.horizontal, 8)
    }
}


struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(time: "16", iconName: "nuvoloso", temperature: "12°C")
            .background(.blue)
    }
}
