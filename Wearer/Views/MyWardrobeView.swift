//
//  WardrobeView.swift
//  Wearer
//
//  Created by Alberto Mura on 13/01/23.
//

import SwiftUI

struct WardrobeView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            HClothViewer(clothType: "cloth")
            HClothViewer(clothType: "shirt")
            HClothViewer(clothType: "jeans")
            HClothViewer(clothType: "shoes")
        }
    }
}

struct MyWardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeView()
    }
}
