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
        ScrollView(showsIndicators: false) {
            HClothViewer(clothType: "cloth")
        }
    }
}
struct ClothesList_Previews: PreviewProvider {
    static var previews: some View {
        ClothesList()
    }
}
