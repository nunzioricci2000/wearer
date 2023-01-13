//
//  MainView.swift
//  Wearer
//
//  Created by Pietro Ciuci on 12/01/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack  {
            topWeather
            BottomSheetView(isOpen: .constant(true), maxHeight: 520) { //520 - 680
                VStack(alignment: .leading, spacing: 20) {
                    Text("Today's Suggestions")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .padding(.horizontal)
                    
                    GeometryReader { geometry in
                        VStack{
                            HStack{
                                Spacer()
                                Image("sweater")
                                    .resizable()
                                    .frame(width: geometry.size.width*0.40)
                                    .frame(height: geometry.size.width*0.40)
                                    .scaledToFill()
                                    .cornerRadius(22)
                                Spacer()
                                Image("t-shirt")
                                    .resizable()
                                    .frame(width: geometry.size.width*0.40)
                                    .frame(height: geometry.size.width*0.40)
                                    .scaledToFill()
                                    .cornerRadius(22)
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            HStack {
                                Spacer()
                                Image("jeans")
                                    .resizable()
                                    .frame(width: geometry.size.width*0.40)
                                    .frame(height: geometry.size.width*0.40)
                                    .scaledToFill()
                                    .cornerRadius(22)
                                Spacer()
                                Image("shoes")
                                    .resizable()
                                    .frame(width: geometry.size.width*0.40)
                                    .frame(height: geometry.size.width*0.40)
                                    .scaledToFill()
                                    .cornerRadius(22)
                                Spacer()
                                
                            }
                            Spacer()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var topWeather: some View {
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
                    hWeather
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
    
    var hWeather: some View {
        HStack {
            ForEach(1...6, id: \.self) { index in
                hWeatherIcon
            }
        }
    }
    
    var hWeatherIcon: some View {
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView().topWeather.previewDisplayName("topWeather")
        MainView().hWeather.previewDisplayName("hWeather")
        MainView().hWeatherIcon.previewDisplayName("hWeatherIcon")
    }
}


