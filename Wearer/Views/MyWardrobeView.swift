//
//  WardrobeView.swift
//  Wearer
//
//  Created by Alberto Mura on 13/01/23.
//

import SwiftUI

struct WardrobeView: View {
    let cloth = Cloth(name: "Sabaku", type: ClothType.jacket, picture: "")
    let jeans = Cloth(name: "Jeans Figo", type: ClothType.jeans, picture: "")
    let shoes = Cloth(name: "Scarpe Fighe", type: ClothType.shoes, picture: "")
    let shirt = Cloth(name: "Magliette Fighe", type: ClothType.shirt, picture: "")
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HClothViewer(cloth: cloth)
                HClothViewer(cloth: shirt)
                HClothViewer(cloth: jeans)
                HClothViewer(cloth: shoes)
                    .navigationTitle("My Wardrobe")
            }
        }
    }
}

struct MyWardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeView()
    }
}
