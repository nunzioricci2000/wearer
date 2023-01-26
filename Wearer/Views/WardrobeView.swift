//
//  WardrobeView.swift
//  Wearer
//
//  Created by Nunzio Ricci on 23/01/23.
//

import SwiftUI

extension MainView {
    var wardrobeView: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "chevron.left")
                        .onTapGesture {
                            withAnimation {
                                showWardrobe = false
                            }
                        }
                    Title("My wardrobe")
                        .matchedGeometryEffect(id: "wardrobe-title", in: namespace)
                }.padding()
                WardrobeView()
            }
        }
    }
}

struct WardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().wardrobeView
    }
}
