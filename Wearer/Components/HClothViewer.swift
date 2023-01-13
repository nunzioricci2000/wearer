//
//  ShoesView.swift
//  Wearer
//
//  Created by Alberto Mura on 13/01/23.
//

import SwiftUI

struct HClothViewer: View {
    var cloth : Cloth
    var body: some View {
        VStack{
            HStack {
                Text(cloth.type.rawValue)
                    .fontWeight(.heavy)
                    .font(.title)
                Image(systemName: "chevron.down")
            }
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                }
                    .padding(.leading)
            }
        }
    }
}

struct HClothViewer_Previews: PreviewProvider {
    static var previews: some View {
        HClothViewer(cloth: Cloth(name: "Sabaku", type: ClothType.jeans, picture: ""))
    }
}
