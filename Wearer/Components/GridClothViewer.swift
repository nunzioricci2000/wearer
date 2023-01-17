//
//  GridClothViewer.swift
//  Wearer
//
//  Created by Alberto Mura on 17/01/23.
//

import SwiftUI

struct GridClothViewer: View {
    var body: some View {
        ScrollView{
                Image("Jeans1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165, height: 165)
                    .clipShape(Rectangle())
                    .cornerRadius(30)
                Image("Jeans1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165, height: 165)
                    .clipShape(Rectangle())
                    .cornerRadius(30)
                Image("Jeans1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165, height: 165)
                    .clipShape(Rectangle())
                    .cornerRadius(30)
                Image("Jeans1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165, height: 165)
                    .clipShape(Rectangle())
                    .cornerRadius(30)
                Image("Jeans1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165, height: 165)
                    .clipShape(Rectangle())
                    .cornerRadius(30)
            }
            .padding(.leading)
        }
}

struct GridClothViewer_Previews: PreviewProvider {
    static var previews: some View {
        GridClothViewer()
    }
}
