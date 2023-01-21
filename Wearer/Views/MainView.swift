//
//  MainView.swift
//  Wearer
//
//  Created by Pietro Ciuci on 12/01/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: ViewModel = .init()
    var body: some View {
        weatherView
            .semisheet(minHeight: 105,
                       maxHeight: 250) {
                wardrobe
            }.background {
                background
            }.alert(isPresented: $viewModel.showAlert) {
                alert
            }
            .onAppear {
                Task {
                    await viewModel.refresh()
                }
            }
    }
    var weatherView: some View {
        VStack {
            Grid(verticalSpacing: 10) {
                mainWeather
                weatherForegrounds
                weatherQuote
            }
            .foregroundColor(.white)
            .fontDesign(.rounded)
            .shadow(color: .black .opacity(0.5), radius: 3, y: 4)
        }
    }
    var mainWeather: some View {
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
    }
    var weatherForegrounds: some View {
        GridRow {
            ForEach(viewModel.foregrounds, id: \.?.time) { foreground in
                weatherIcon(foreground ?? .init())
            }
        }
    }
    var weatherQuote: some View {
        GridRow {
            Text(viewModel.currentWeatherDescription ?? "...")
                .gridCellColumns(6)
                .padding(.vertical, 10)
        }
    }
    var wardrobe: some View {
        modalBackground
            .overlay(alignment: .top) {
                VStack {
                    modalPiripicchio
                    Title("Today's suggestions")
                    suggestions
                    wardrobeButton
                }
            }
    }
    var modalBackground: some View {
            Color(.systemBackground)
                .cornerRadius(20, corners: [.topLeft, .topRight]).ignoresSafeArea()
    }
    var modalPiripicchio: some View {
        Color.secondary.cornerRadius(20).frame(width: 50, height: 5).padding(.top)
    }
    var suggestions: some View {
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
    }
    var wardrobeButton: some View {
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
    var alert: Alert {
        Alert(
            title: Text(viewModel.alert!.title),
            message: Text(viewModel.alert!.description),
            dismissButton: .default(Text(viewModel.alert!.buttonText))
        )
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
    var background: some View {
        Rectangle()
            .fill(Gradient(colors: [.blue .opacity(0.6), .blue]))
            .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDisplayName("Main")
        MainView().weatherView
            .previewDisplayName("Weather")
    }
}
