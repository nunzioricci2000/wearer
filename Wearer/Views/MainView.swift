//
//  MainView.swift
//  Wearer
//
//  Created by Pietro Ciuci on 12/01/23.
//

import SwiftUI

struct MainView: View {
    @State var yGestureOffset: CGFloat = 0
    @State var gestureStatus: Bool = true
    @State var minHeight: CGFloat = 0
    @State var maxHeight: CGFloat = 0
    @State var notchHeight: CGFloat = 0
    
    var actualHeight: CGFloat {
        return (gestureStatus ? maxHeight : minHeight) + yGestureOffset
    }
    
    var selectedGestureStatus: Bool {
        return actualHeight > (maxHeight + minHeight) / 2
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            weatherView
            
            VStack {
                Color.clear.frame(width: 0, height: actualHeight)
                wardrobe.frame(width: UIScreen.main.bounds.width)
            }
        }.compositingGroup()
        .background {
            Rectangle()
                .fill(Gradient(colors: [.blue .opacity(0.6), .blue]))
                .ignoresSafeArea()
        }.gesture( DragGesture()
            .onChanged { gesture in
                withAnimation(.interactiveSpring()) {
                    yGestureOffset = gesture.translation.height
                }
            }.onEnded { gesture in
                withAnimation(.interactiveSpring()) {
                    gestureStatus = selectedGestureStatus
                    yGestureOffset = 0
                }
            }
        )
    }
    
    var weatherView: some View {
        VStack {
            GeometryReader { rect in
                Color.clear.onAppear {
                    notchHeight = rect.frame(in: .global).maxY
                }
            }.frame(width: 0, height: 0)
            Grid (verticalSpacing: 10) {
                GridRow{
                    VStack{
                        Text("Napoli")
                        Text("15°C")
                    }
                    .gridCellColumns(2)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    
                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                        .gridCellColumns(1)
                    
                    Image(systemName: "cloud.sun")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .font(.system(size: 32, weight: .light, design: .rounded))
                        .gridCellColumns(3)
                }
                GeometryReader { rect in
                    Color.clear.onAppear {
                        minHeight = rect.frame(in: .global).minY - notchHeight
                    }
                }.frame(width: 0, height: 0)
                GridRow{
                    ForEach(1...6, id: \.self) { index in
                        hWeatherIcon
                    }
                }
                GridRow{
                    Text("Seems like it could rain today, don't forget your umbrella \(Image(systemName: "umbrella"))")
                        .gridCellColumns(6)
                        .padding(.vertical,10)
                }
                GeometryReader {rect in
                    Color.clear.onAppear {
                        maxHeight = rect.frame(in: .global).minY - notchHeight
                    }
                }.frame(width: 0, height: 0)
            }
            .foregroundColor(.white)
            .fontDesign(.rounded)
            .shadow(color: .black .opacity(0.5), radius: 3, y: 4)
        }
    }
    
    var wardrobe: some View {
        ZStack {
            Color.white.cornerRadius(20).ignoresSafeArea()
            Color.clear.overlay(alignment: .top) {
                VStack {
                    Color.secondary.cornerRadius(20).frame(width: 50, height: 5).padding(.top)
                    Title("Today's suggestions")
                    Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                        GridRow {
                            Image("sweater")
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(22)
                            Image("t-shirt")
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(22)
                        }
                        GridRow {
                            Image("jeans")
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(22)
                            Image("shoes")
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(22)
                        }
                    }
                    .padding(.horizontal, 40)
                    Color.clear.overlay(alignment: .top) {
                        VStack {
                            Title("My guardrobe")
                                .foregroundColor(.white)
                                .padding(.bottom, 7)
                            Spacer()
                        }.background {
                            ZStack {
                                Image("guardrobe")
                                Color.black.opacity(0.5)
                            }
                        }.cornerRadius(20)
                            .padding()
                    }
                }
            }.blendMode(.sourceAtop)
        }.compositingGroup()
    }
    
    var hWeather: some View {
        HStack {
            
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
        MainView().weatherView.previewDisplayName("weatherView")
        MainView().hWeather.previewDisplayName("hWeather")
        MainView().hWeatherIcon.previewDisplayName("hWeatherIcon")
    }
}

