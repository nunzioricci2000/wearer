////
////  MainView.swift
////  Wearer
////
////  Created by Pietro Ciuci on 12/01/23.
////
//
import SwiftUI
//
// swiftlint:disable all
//

struct MainView: View {
    //@FetchRequest(entity: Cloth.entity(), sortDescriptors: []) var clothes: FetchedResults<Cloth>
    @StateObject var viewModel: MainViewViewModel = .init()
    var body: some View {
        NavigationStack {
            ZStack {
                background
                    .ignoresSafeArea(.all)
                VStack {
                    Grid(verticalSpacing: 10) {
                        mainWeather
                            .padding(.top)
                        weatherForegrounds
                            .padding(.top)
                        weatherQuote
                            .padding(.top, 5)
                    }
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                    .shadow(color: .black .opacity(0.5), radius: 3, y: 4)
                    .padding(.top, 20)
                    Spacer()
                    VStack {
                        wardrobe
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.refresh()
                    }
                }
                .ignoresSafeArea(edges: .bottom)
                .alert(isPresented: $viewModel.showAlert) {
                    alert
                }
            }
        }
    }
}

extension MainView {
    
    var alert: Alert {
        Alert(
            title: Text(viewModel.alert!.title),
            message: Text(viewModel.alert!.description),
            dismissButton: .default(Text(viewModel.alert!.buttonText)) { viewModel.alert!.onDismiss() }
        )
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
    
    var background: some View {
        Rectangle()
            .fill(Gradient(colors: [.blue .opacity(0.6), .blue]))
            .ignoresSafeArea()
    }
    
    var suggestions: some View {
        Grid(horizontalSpacing: 18, verticalSpacing: 18) {
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
    
    var wardrobe: some View {
        VStack {
            Text("Today's suggestions")
                .title()
                .padding()
            suggestions
            wardrobeButton
                .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        //.frame(height: 540)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
    
    var wardrobeButton: some View {
        NavigationLink {
            WardrobeView()
        } label: {
            VStack {
                Text("My wardrobe")
                    .title()
                    .foregroundColor(.white)
                    .padding(.bottom, 7)
                Spacer()
            }.background {
                ZStack {
                    Image("wardrobe")
                    Color.black.opacity(0.5)
                }
            }.cornerRadius(20)
                .padding()
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
