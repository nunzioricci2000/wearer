//
//  WardrobeView.swift
//  Wearer
//
//  Created by Nunzio Ricci on 23/01/23.
//

import SwiftUI

struct WardrobeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Grid(horizontalSpacing: 25, verticalSpacing: 25) {
                    GridRow {
                        NavigationLink {
                            ClothListView("Coats")
                        } label: {
                            Image("CoatPlaceholder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                                .overlay (
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.black)
                                            .frame(width: 160, height: 160)
                                            .opacity(0.3)
                                        Caption(text: "Coats")
                                            .foregroundColor(.white)
                                            .shadow(radius: 3)
                                    }
                                )
                        }
                        NavigationLink {
                            ClothListView("Shirts")
                        } label: {
                            Image("ShirtPlaceholder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                                .overlay (
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.black)
                                            .frame(width: 160, height: 160)
                                            .opacity(0.3)
                                        Caption(text: "Shirts")
                                            .foregroundColor(.white)
                                            .shadow(radius: 3)
                                    }
                                )
                        }
                    }
                    GridRow {
                        NavigationLink {
                            ClothListView("Pants")
                        } label: {
                            Image("PantsPlaceholder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                                .overlay (
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.black)
                                            .frame(width: 160, height: 160)
                                            .opacity(0.3)
                                        Caption(text: "Pants")
                                            .foregroundColor(.white)
                                            .shadow(radius: 3)
                                    }
                                )
                        }
                        NavigationLink {
                            ClothListView("Shoes")
                        } label: {
                            Image("ShoesPlaceholder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                                .overlay (
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.black)
                                            .frame(width: 160, height: 160)
                                            .opacity(0.3)
                                        Caption(text: "Shoes")
                                            .foregroundColor(.white)
                                            .shadow(radius: 3)
                                    }
                                )
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, 55)
            .navigationTitle("My Wardrobe")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct WardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeView()
    }
}
