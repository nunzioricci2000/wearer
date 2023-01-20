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
    @ObservedObject var viewModel: OMViewModel

    var actualOffset: CGFloat {
        (gestureStatus ? maxHeight : minHeight) + yGestureOffset
    }
    var actualHeight: CGFloat {
        guard actualOffset > 0 else {
            return 0
        }
        if actualOffset > maxHeight {
            return maxHeight + (actualOffset - maxHeight) / 2
        }
        return actualOffset
    }
    var selectedGestureStatus: Bool {
        return actualHeight > (maxHeight + minHeight) / 2
    }
    var body: some View {
        semimodal {
            weatherView
        } modal: {
            wardrobe
        }.background {
            Rectangle()
                .fill(Gradient(colors: [.blue .opacity(0.6), .blue]))
                .ignoresSafeArea()
        }
    }
    var weatherView: some View {
        VStack {
            GeometryReader { rect in
                Color.clear.onAppear {
                    notchHeight = rect.frame(in: .global).midY
                }
            }.frame(width: 0, height: 0)
            Grid(verticalSpacing: 10) {
                GridRow {
                    VStack {
                        Text(viewModel.cityName)
                        Text(viewModel.temperature)
                    }
                    .gridCellColumns(2)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                        .gridCellColumns(1)
                    Image(viewModel.weatherIcon)
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
                GridRow {
                    ForEach(1...6, id: \.self) { index in
                        weatherIcon(index)
                    }
                }
                GridRow {
                    Text(viewModel.weatherDescription)
                        .gridCellColumns(6)
                        .padding(.vertical, 10)
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
        .alert(isPresented: $viewModel.shouldShowLocationError) {
          Alert(
            title: Text("Error"),
            message: Text("To see the weather, provide location access in Settings."),
            dismissButton: .default(Text("Open Settings")) {
              guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
              UIApplication.shared.open(settingsURL)
            }
          )
        }
        .onAppear(perform: viewModel.refresh)
    }
    var wardrobe: some View {
        ZStack {
            Color(.systemBackground)
                .cornerRadius(20, corners: [.topLeft, .topRight]).ignoresSafeArea()
            .overlay(alignment: .top) {
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
            }
        }.compositingGroup()
    }
    func weatherIcon(_ index: Int) -> some View {
        let temp = viewModel.omService.response?.hourly.temperature[index*4]
        var tempStr: String?
        if let temp = temp {
            tempStr = "\(temp)°C"
        }
        let hour = viewModel.omService.response?.hourly.time[index*4]
        var hourStr: String?
        if let hour = hour {
            let startIndex = hour.index(hour.startIndex, offsetBy: 11)
            let endIndex = hour.index(startIndex, offsetBy: 1)
            hourStr = String(hour[startIndex...endIndex])
        }
        let code = viewModel.omService.response?.hourly.weatherCode[index*4]
        var weatherIconName: String?
        if let code = code {
            weatherIconName = OMForeground.from(code: code).weatherIcon
        }
        return VStack {
            Text(hourStr ?? "--") // hour
            Image(weatherIconName ?? "") // SF Symbol icon
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
            Text(tempStr ?? "--")
        }
        .font(.system(size: 12, weight: .regular, design: .rounded))
        .padding(.horizontal, 8)
    }
    func semimodal<Content: View, Modal: View>(
        @ViewBuilder content: () -> Content,
        @ViewBuilder modal: () -> Modal
    ) -> some View {
        ZStack(alignment: .top) {
            content()
            VStack {
                Color.clear
                    .frame(width: 0, height: actualHeight)
                modal()
            }
        }.gesture( DragGesture()
            .onChanged { gesture in
                withAnimation(.interactiveSpring()) {
                    yGestureOffset = gesture.translation.height
                }
            }.onEnded { _ in
                withAnimation(.interactiveSpring()) {
                    gestureStatus = selectedGestureStatus
                    yGestureOffset = 0
                }
            }
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: OMViewModel(omService: OMService()))
            .previewDisplayName("Main")
        MainView(viewModel: OMViewModel(omService: OMService())).weatherView
            .previewDisplayName("Weather")
    }
}
