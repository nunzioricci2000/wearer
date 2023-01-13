//
//  TopWeather.swift
//  Wearer
//
//  Created by Pietro Ciuci on 12/01/23.
//

import SwiftUI

struct TopWeather: View {
    var body: some View {
//        Color.blue
//                .ignoresSafeArea()
//                .overlay(
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [.blue .opacity(0.6), .blue]))
                .ignoresSafeArea()
            GeometryReader{ geometry in
                
                
                VStack {
                    HStack {
                        VStack {
                            Text("Napoli")
                            Text("15°C")
                        }
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        Spacer()
                        Image(systemName: "cloud.sun")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width*0.40)
                            .font(.system(size: 32, weight: .light, design: .rounded))
                    }
                    .padding(.horizontal, 25)
                    HWeather()
                    Text("Seems like it could rain today, don't forget your umbrella \(Image(systemName: "umbrella"))")
                        .frame(width: geometry.size.width*0.9)
                        .padding(.top)
                    Spacer()
                }
                .foregroundColor(.white)
                .fontDesign(.rounded)
                .shadow(color: .black .opacity(0.5), radius: 3, y: 4)
                
            }
        }
    }
}

struct TopWeather_Previews: PreviewProvider {
    static var previews: some View {
        TopWeather()
    }
}
