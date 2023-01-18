//
//  GridClothViewer.swift
//  Wearer
//
//  Created by Alberto Mura on 17/01/23.
//

import SwiftUI

struct GridClothViewer: View {
    var body: some View {
        VStack{
            Text ("Jackets")
                .bold()
                .font(.title2)
            ScrollView(.vertical){
                Grid {
                    GridRow {
                        Image("Jeans1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.top, 4.0)
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
                    GridRow {
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
                    GridRow {
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
                    GridRow {
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
                    
                }
            }
        }
        .padding(.top, 8.0)
    }
}

struct GridClothViewer_Previews: PreviewProvider {
    static var previews: some View {
        GridClothViewer()
    }
}
