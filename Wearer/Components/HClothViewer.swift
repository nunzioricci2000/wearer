//
//  ShoesView.swift
//  Wearer
//
//  Created by Alberto Mura on 13/01/23.
//

import SwiftUI

// swiftlint: disable all

struct HClothViewer: View {
    let generator = UIImpactFeedbackGenerator(style: .light)
    @FetchRequest(entity: Cloth.entity(), sortDescriptors: []) var clothes: FetchedResults<Cloth>
    @State var clothType: String = "Panths"
    var body: some View {
        VStack {
            NavigationLink {
                GridClothViewer(clothType: clothType)
            } label: {
                HStack {
                    Text(clothType)
                        .fontWeight(.heavy)
                        .font(.title)
                    Image(systemName: "plus.circle.fill")
                    Spacer()
                }
                .padding(.leading, 20.0)
            }
            .buttonStyle(PlainButtonStyle())
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(clothes) { cloth in
                        if clothType.lowercased() == cloth.type?.lowercased() {
                            NavigationLink(destination: {
                                DetailView(cloth: cloth, name: cloth.name ?? "", image: UIImage(data: cloth.picture ?? UIImage(imageLiteralResourceName: "ClothPlaceholder").pngData()!), type: cloth.type ?? "Unknown", warmIndex: 4)
                            }, label: {
                                Image(uiImage: .init(data: cloth.picture ?? UIImage(imageLiteralResourceName: "ClothPlaceholder").pngData()!) ?? UIImage(imageLiteralResourceName: "ClothPlaceholder"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 165)
                                    .clipShape(Rectangle())
                                .cornerRadius(30)
                            })
                        }
                    }
                }.padding(.leading)
            }
        }
    }
}

struct HClothViewer_Previews: PreviewProvider {
    static var previews: some View {
        HClothViewer()
    }
}
