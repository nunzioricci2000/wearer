//
//  ClothesList.swift
//  Wearer
//
//  Created by Alberto Mura on 16/01/23.
//

import SwiftUI

struct ClothesList: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        let cloth = Cloth(name: "Jackette Fighe", type: ClothType.jacket, picture: "")
        let jeans = Cloth(name: "Jeans Figo", type: ClothType.jeans, picture: "")
        let shoes = Cloth(name: "Scarpe Fighe", type: ClothType.shoes, picture: "")
        let shirt = Cloth(name: "Scarpe Fighe", type: ClothType.shirt, picture: "")
        ScrollView(showsIndicators: false) {
            HClothViewer(cloth: cloth)
        }
    }
}
struct ClothesList_Previews: PreviewProvider {
    static var previews: some View {
        ClothesList()
    }
}
