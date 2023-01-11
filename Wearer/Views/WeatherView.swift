//
//  WeatherView.swift
//  Wearer
//
//  Created by Nunzio Ricci on 10/01/23.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var namespace: NamespaceWrapper
    @EnvironmentObject var currentPage: PageWrapper
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.blue.ignoresSafeArea()
            Grid {
                GridRow(alignment: .center) {
                    Text("Hi Ashley!")
                        .font(.title)
                        .fontWeight(.bold)
                        .gridColumnAlignment(.leading)
                    Image("cloudy")
                        //.matchedGeometryEffect(id: "icon", in: namespace.value)
                }
                GridRow(alignment: .center) {
                    Color.clear
                        .gridCellUnsizedAxes(.vertical)
                    Text("15 C°")
                        .font(.title)
                        .fontWeight(.bold)
                        //.matchedGeometryEffect(id: "temp", in: namespace.value)
                }
            }.padding(30)
        }.foregroundColor(.white)
            .onTapGesture {
                withAnimation(.linear(duration: 1)) {
                    currentPage.page = AnyView(ClothesView())
                }
            }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice(.init(rawValue: "iPhone 13"))
    }
}
