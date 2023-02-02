//
//  ClothesList.swift
//  Wearer
//
//  Created by Alberto Mura on 16/01/23.
//

import SwiftUI

// swiftlint:disable all

struct ClothListView: View {
    @FetchRequest var clothes: FetchedResults<Cloth>
    @State var isPresented = false
    @State var type: String
    let imagePlaceholder = UIImage(imageLiteralResourceName: "ClothPlaceholder").pngData()
    
    init(_ type: String) {
        _clothes = FetchRequest(sortDescriptors: [],
                                predicate: NSPredicate(format: "type LIKE[cd] %@", type))
        _type = State(initialValue: type)
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(clothes) { cloth in
                    NavigationLink {
                        ClothEditorView(cloth: cloth, type: cloth.type!, warmIndex: Int(cloth.warmness))
                    } label: {
                        ClothDisplayer(picture: UIImage(data: cloth.picture ?? imagePlaceholder!) ?? UIImage(imageLiteralResourceName: "ClothPlaceholder"))
                            .padding()
                    }
                }
            }
        }
        .navigationTitle(type)
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
        .sheet(isPresented: $isPresented) {
            ClothCreationView(type: type)
        }
    }
}
struct ClothListView_Previews: PreviewProvider {
    static var previews: some View {
        ClothListView("Coats")
    }
}
