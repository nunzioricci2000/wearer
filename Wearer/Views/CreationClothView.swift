//
//  CreationClothView.swift
//  Wearer
//
//  Created by Alberto Mura on 23/01/23.
//

import SwiftUI

struct CreationClothView: View {
    @State var name: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image("ClothPlaceholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.top, 4.0)
                        .frame(width: 165, height: 165)
                        .clipShape(Rectangle())
                        .cornerRadius(30)
                    Image("NewPic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.top, 150.0)
                        .frame(width: 60, height: 60)
                        .navigationTitle("New Cloth")
                }
                HStack {
                    TextField("Name", text: $name)
                        .padding()
                }
                .frame(width: 400, height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(14)
                .padding(.top, 40.0)
                Picker(selection: .constant(1), label: Text("Category")) {
                    Text("Jeans").tag(1)
                    Text("Jackets").tag(2)
                    Text("Hats").tag(2)
                    Text("Shoes").tag(2)
                }
                .pickerStyle(.automatic)
                .padding()
                .frame(width: 400, height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(14)
                .padding(.top)
                Spacer()
                CreateButton()
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
        }
    }
}

struct CreationClothView_Previews: PreviewProvider {
    static var previews: some View {
        CreationClothView(name: "")
    }
}
