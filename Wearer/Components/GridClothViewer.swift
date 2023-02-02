////
////  GridClothViewer.swift
////  Wearer
////
////  Created by Alberto Mura on 17/01/23.
////
//
//import SwiftUI
//
//struct GridClothViewer: View {
//    @State var isPresented: Bool = false
//    @State var isSelected: Bool = false
//    @State var clothType: String
//    @FetchRequest(entity: Cloth.entity(), sortDescriptors: []) var clothes: FetchedResults<Cloth>
//    var body: some View {
//        VStack {
//            Text("Jackets")
//                .bold()
//                .font(.title2)
//            ScrollView(.vertical) {
//                LazyVGrid(columns: [GridItem(alignment: .trailing), GridItem(alignment: .leading)]) {
//                    ForEach(clothes) { cloth in
//                        if let data = cloth.picture ?? UIImage(named: "ClothPlaceholder")!.pngData(),
//                           let image = UIImage(data: data) ?? UIImage(named: "ClothPlaceholder")!,
//                           clothType.lowercased() == cloth.type?.lowercased() {
//                            Image(uiImage: image)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 165, height: 165)
//                                .clipShape(Rectangle())
//                                .cornerRadius(30)
//                        }
//                    }
//                    Button {
//                        isPresented = true
//                        isSelected.toggle()
//                    }
//                label: {
//                    HStack {
//                        Image("NewCloth")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 165, height: 165)
//                            .clipShape(Rectangle())
//                        .cornerRadius(30)                        }
//                }
//                }
//            }
//        }
//        .padding(.top, 8.0)
//        .sheet(isPresented: $isPresented) {
//            ClothCreationView(name: "")
//        }
//    }
//}
