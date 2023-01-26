//
//  GridClothViewer.swift
//  Wearer
//
//  Created by Alberto Mura on 17/01/23.
//

import SwiftUI

struct GridClothViewer: View {
    @State var isPresented: Bool = false
    @State var isSelected: Bool = false
    var body: some View {
        VStack {
            Text("Jackets")
                .bold()
                .font(.title2)
            ScrollView(.vertical) {
                Grid {
                    GridRow {
                        Image("Jeans1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.top, 4.0)
                            .frame(width: 165, height: 165)
                            .clipShape(Rectangle())
                            .cornerRadius(30)
                        Image("Jeans2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 165, height: 165)
                            .clipShape(Rectangle())
                            .cornerRadius(30)
                    }
                    GridRow {
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
                    }
                    GridRow {
                        Image("Jeans5")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 165, height: 165)
                            .clipShape(Rectangle())
                            .cornerRadius(30)
                        Image("Hat1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 165, height: 165)
                            .clipShape(Rectangle())
                            .cornerRadius(30)
                    }
                    GridRow {
                        Image("Sweater1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 165, height: 165)
                            .clipShape(Rectangle())
                            .cornerRadius(30)
                        Button {
                            isPresented = true
                            isSelected.toggle()
                        }
                    label: {
                        HStack {
                            Image("NewCloth")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 165, height: 165)
                                .clipShape(Rectangle())
                            .cornerRadius(30)                        }
                    }
                    }
                }
            }
        }
        .padding(.top, 8.0)
        .sheet(isPresented: $isPresented) {
            CreationClothView(name: "")
    }
        }
}
struct GridClothViewer_Previews: PreviewProvider {
    static var previews: some View {
        GridClothViewer()
    }
}
