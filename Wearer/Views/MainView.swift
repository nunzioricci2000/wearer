////
////  MainView.swift
////  Wearer
////
////  Created by Pietro Ciuci on 12/01/23.
////
//
import SwiftUI
import CoreData
//
// swiftlint:disable all
//

struct MainView: View {
    @FetchRequest(sortDescriptors: []) var clothes: FetchedResults<Cloth>
    @StateObject var viewModel: MainViewViewModel = .init()
    let imagePlaceholder = UIImage(imageLiteralResourceName: "ErrorIcon").pngData()
    @State var temperature: String?
    @State var coat: Cloth?
    @State var shirt: Cloth?
    @State var pants: Cloth?
    @State var shoes: Cloth?
    @State var isLoading = true
    
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
                .ignoresSafeArea(edges: .bottom)
                .alert(isPresented: $viewModel.showAlert) {
                    alert
                }
                .onAppear {
                    Task {
                        await viewModel.refresh()
                        if (isLoading == true) {
                            temperature = viewModel.currentWeather?.temperature ?? "5000"
                            let removeCharacters: Set<Character> = ["C", "°"]
                            temperature?.removeAll(where: { removeCharacters.contains($0) } )
                            coat = getSuggestedCloth(temp: temperature ?? "45", type: "Coats")
                            shirt = getSuggestedCloth(temp: temperature ?? "45", type: "Shirts")
                            pants = getSuggestedCloth(temp: temperature ?? "45", type: "Pants")
                            shoes = getSuggestedCloth(temp: temperature ?? "45", type: "Shoes")
                        }
                        isLoading = false
                    }
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
    
    @ViewBuilder
    var suggestions: some View {
        if isLoading == true {
            Grid(horizontalSpacing: 18, verticalSpacing: 18) {
                GridRow {
                    ProgressView()
                        .frame(width: 160, height: 160)
                        .background(Color(.systemGray6))
                        .cornerRadius(22)
                    ProgressView()
                        .frame(width: 160, height: 160)
                        .background(Color(.systemGray6))
                        .cornerRadius(22)
                }
                GridRow {
                    ProgressView()
                        .frame(width: 160, height: 160)
                        .background(Color(.systemGray6))
                        .cornerRadius(22)
                    ProgressView()
                        .frame(width: 160, height: 160)
                        .background(Color(.systemGray6))
                        .cornerRadius(22)
                }
            }
        }
        else {
            Grid(horizontalSpacing: 18, verticalSpacing: 18) {
                GridRow {
                    ClothDisplayer(picture: UIImage(data: coat?.picture ?? imagePlaceholder!) ?? UIImage(imageLiteralResourceName: "jeans"))
                    ClothDisplayer(picture: UIImage(data: shirt?.picture ?? imagePlaceholder!)
                                   ?? UIImage(imageLiteralResourceName: "t-shirts"))
                }
                GridRow {
                    ClothDisplayer(picture: UIImage(data: pants?.picture ?? imagePlaceholder!)
                                   ?? UIImage(imageLiteralResourceName: "jeans"))
                    ClothDisplayer(picture: UIImage(data: shoes?.picture ?? imagePlaceholder!)
                                   ?? UIImage(imageLiteralResourceName: "shoes"))
                }
            }
            .padding(.horizontal, 40)
        }
    }
    
    var wardrobe: some View {
        VStack {
            HStack {
                Text("Today's suggestions")
                    .title()
                Spacer()
                Button {
                    Task {
                        await viewModel.refresh()
                        temperature = viewModel.currentWeather?.temperature ?? "5000"
                        let removeCharacters: Set<Character> = ["C", "°"]
                        temperature?.removeAll(where: { removeCharacters.contains($0) } )
                        coat = getSuggestedCloth(temp: temperature ?? "45", type: "Coats")
                        shirt = getSuggestedCloth(temp: temperature ?? "45", type: "Shirts")
                        pants = getSuggestedCloth(temp: temperature ?? "45", type: "Pants")
                        shoes = getSuggestedCloth(temp: temperature ?? "45", type: "Shoes")
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .font(.title)
                }
                .padding([.top, .horizontal])
            }
            .padding()
            suggestions
            wardrobeButton
                .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
    
    // MARK: Functions
    
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
    
    func filterClothesByTemp(temp: Double) -> [Cloth] {
        let warmIndex = convertIndex(for: temp)
        var tempFilteredClothes: [Cloth] = []
        for cloth in self.clothes {
            if cloth.warmness == warmIndex {
                tempFilteredClothes.append(cloth)
            }
        }
        return tempFilteredClothes
    }
    
    func filterClothesByType(clothes: [Cloth], type: String) -> [Cloth] {
        var filteredClothes: [Cloth] = []
        for cloth in clothes {
            if cloth.type == type {
                filteredClothes.append(cloth)
            }
        }
        return filteredClothes
    }
    
    func convertIndex(for temp: Double) -> Int {
        switch(temp) {
        case let x where x < 0.0:
            return 5
        case let x where x >= 0.0 && x < 10.0:
            return 4
        case let x where x >= 10.0 && x < 20.0:
            return 3
        case let x where x >= 20.0 && x < 30.0:
            return 2
        case let x where x >= 30.0:
            return 1
        default:
            return 3 // medium value
        }
    }
    
    func getSuggestedCloth(temp: String, type: String) -> Cloth? {
        let temperature = Double(temp)
        let tempFilteredClothes = filterClothesByTemp(temp: temperature ?? 35)
        return filterClothesByType(clothes: tempFilteredClothes, type: type).randomElement()
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
