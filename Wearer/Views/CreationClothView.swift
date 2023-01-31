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
    @Environment(\.managedObjectContext) var moc
    @State var image: UIImage?
    @State var type: String = "Jeans"
    @State var warmness: Int = 1
    let colors: [String] = ["Black", "Brown", "Yellow", "White", "Blue", "Green", "Orange", "Red", "Pink"]
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    CameraView(selectedImage: $image)
                } label: {
                    ZStack {
                        Image(uiImage: image ?? UIImage(imageLiteralResourceName: "ClothPlaceholder"))
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
                }
                .padding()
//                HStack {
//                    TextField("Name", text: $name)
//                        .padding()
//                }
//                .frame(width: 400, height: 50)
//                .background(Color(.systemGray6))
//                .cornerRadius(14)
//                .padding(.top, 40.0)
                Picker(selection: $type, label: Text("Category")) {
                    ForEach(colors, id: \.self) { color in
                        HStack {
                            Circle()
                                .fill(Color(color))
                                .frame(width: 15)
                            Text(color)
                        }
                    }
                }
                .pickerStyle(.navigationLink)
                .padding()
                .frame(width: 400, height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(14)
                .padding(.top)
                WarmnessPicker(rating: $warmness, isEditing: .constant(true))
                    .padding(.top)
                Spacer()
                Button {
                    let cloth = Cloth( context: moc)
                    cloth.picture = image?.pngData()
                    cloth.type = type
                    cloth.warmness = Int16(warmness)
                    try? moc.save()
                    dismiss()
                }label: {
                Text("Create")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.blue)
                    .frame(width: 400, height: 70)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                }
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
