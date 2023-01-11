//
//  MainView.swift
//  Wearer
//
//  Created by Nunzio Ricci on 10/01/23.
//

import SwiftUI

struct MainView: View {
    @Namespace var namespace
    @StateObject var currentPage: PageWrapper = .init(page: AnyView(WeatherView()))
    
    var body: some View {
        currentPage.page
        .environmentObject(NamespaceWrapper(namespace))
        .environmentObject(currentPage)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice(.init(rawValue: "iPhone 13"))
    }
}

class PageWrapper: ObservableObject {
    @Published var page: AnyView
    
    init(page: AnyView) {
        self.page = page
    }
}

class NamespaceWrapper: ObservableObject {
    @Published var value: Namespace.ID
    
    init(_ namespace: Namespace.ID) {
        self.value = namespace
    }
}
