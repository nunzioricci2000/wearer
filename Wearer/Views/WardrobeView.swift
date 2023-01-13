//
//  WardrobeView.swift
//  Wearer
//
//  Created by Alberto Mura on 13/01/23.
//

import SwiftUI

struct WardrobeView: View {
    var cloth = Cloth(name: "Sabaku", type: ClothType.jacket, picture: "")
    var body: some View {
        ScrollView(showsIndicators: false) {
            HClothViewer(cloth: cloth)
            HClothViewer(cloth: cloth)
            HClothViewer(cloth: cloth)
            HClothViewer(cloth: cloth)
            HClothViewer(cloth: cloth)
        }
    }
}

struct WardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeView()
    }
}
