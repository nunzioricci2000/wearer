//
//  ClothesList.swift
//  Wearer
//
//  Created by Alberto Mura on 16/01/23.
//

import SwiftUI

struct ClothListView: View {
    @State var isPresented = false
    @State var category: String
    var body: some View {
        ScrollView(showsIndicators: false) {
            //HClothViewer(clothType: "cloth")
        }
        .navigationTitle(category)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(PlainButtonStyle())
            })
        }
        .sheet(isPresented: $isPresented, content: {ClothCreationView(name: "Test")})
    }
}
struct ClothListView_Previews: PreviewProvider {
    static var previews: some View {
        ClothListView(category: "Coats")
    }
}
