//
//  ClothesView.swift
//  Wearer
//
//  Created by Nunzio Ricci on 10/01/23.
//

import SwiftUI

struct ClothesView: View {
    @EnvironmentObject var namespace: NamespaceWrapper
    @EnvironmentObject var currentPage: PageWrapper
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.blue.ignoresSafeArea()
            HStack {
                    Image("cloudy")
                        //.matchedGeometryEffect(id: "icon", in: namespace.value)
                    Text("15 C°")
                        .font(.title)
                        .fontWeight(.bold)
                        //.matchedGeometryEffect(id: "temp", in: namespace.value)
            }.padding(30)
        }.foregroundColor(.white)
            .onTapGesture {
                currentPage.page = AnyView(WeatherView())
            }
    }
}

struct ClothesView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice(.init(rawValue: "iPhone 13"))
    }
}
