//
//  ShoesView.swift
//  Wearer
//
//  Created by Alberto Mura on 13/01/23.
//

import SwiftUI

struct HClothViewer: View {
    let generator = UIImpactFeedbackGenerator(style: .light)
    var cloth : Cloth
    var body: some View {
        VStack{
            NavigationLink {
                GridClothViewer()
            } label: {
                HStack {
                    Text(cloth.type.rawValue)
                        .fontWeight(.heavy)
                        .font(.title)
                    Image(systemName: "plus.circle.fill")
                    Spacer()
                }
                .padding(.leading, 20.0)
            }
            .buttonStyle(PlainButtonStyle())
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Image("Jeans1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 165, height: 165)
                        .clipShape(Rectangle())
                        .cornerRadius(30)
                    Image("Jeans2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 165, height: 165)
                        .clipShape(Rectangle())
                        .cornerRadius(30)
                    Image("Jeans3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 165, height: 165)
                        .clipShape(Rectangle())
                        .cornerRadius(30)
                    Image("Jeans4")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 165, height: 165)
                        .clipShape(Rectangle())
                        .cornerRadius(30)
                    Image("Jeans5")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 165, height: 165)
                        .clipShape(Rectangle())
                        .cornerRadius(30)
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
