//
//  WeatherQuote.swift
//  Wearer
//
//  Created by Alberto Mura on 31/01/23.
//

import SwiftUI

struct WeatherQuote: View {
    @State var text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .fontWeight(.light)
    }
}

struct WeatherQuote_Previews: PreviewProvider {
    static var previews: some View {
        WeatherQuote(text: "Seems like it could rain today, don't forget the umbrella")
            .background(.blue)
    }
}
