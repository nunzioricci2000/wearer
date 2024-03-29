//
//  CreationClothView.swift
//  Wearer
//
//  Created by Alberto Mura on 23/01/23.
//

import SwiftUI

struct ClothCreationView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var image: UIImage?
    @State var color: String = "Black"
    @State var warmness: Int = 1
    @State var type: String
    @State var isPresentingPhotoPicker = false
    @State var isPhotoLibrary = false
    @State var isCamera = false
    let colors: [String] = ["Black", "Brown", "Yellow", "White", "Blue", "Green", "Orange", "Red", "Pink"]
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    isPresentingPhotoPicker.toggle()
                } label: {
                    ZStack {
                        Image(uiImage: image ?? UIImage(imageLiteralResourceName: "ClothPlaceholder"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 165, height: 165)
                            .clipShape(Rectangle())
                            .cornerRadius(30)
                        Image("NewPic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.top, 150.0)
                            .frame(width: 60, height: 60)
                    }
                }
                .padding()
                Picker(selection: $color, label: Text("Color")) {
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
                .frame(width: 360, height: 50)
                .background(Color(.systemGray5))
                .cornerRadius(14)
                .padding(.top)
                HStack(spacing: 50) {
                    Text("Warmness")
                    WarmnessPicker(rating: $warmness, isEditing: .constant(true))
                }
                .frame(width: 360, height: 45)
                .background(Color(.systemGray5))
                .cornerRadius(14)
                Spacer()
                Button {
                    let cloth = Cloth( context: moc)
                    cloth.picture = image?.pngData()
                    cloth.type = type
                    cloth.color = color
                    cloth.warmness = Int16(warmness)
                    try? moc.save()
                    dismiss()
                }label: {
                    Text("Create")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.blue)
                        .frame(width: 300, height: 55)
                        .background(Color(.systemGray5))
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
            .confirmationDialog("Change item", isPresented: $isPresentingPhotoPicker) {
                Button("Camera") {
                    isCamera.toggle()
                }
                Button("Photo Library") {
                    isPhotoLibrary.toggle()
                }
            }
            .fullScreenCover(isPresented: $isCamera) {
                ImagePickerView(selectedImage: $image, sourceType: .camera)
            }
            .sheet(isPresented: $isPhotoLibrary) {
                ImagePickerView(selectedImage: $image, sourceType: .photoLibrary)
            }
            .navigationTitle("New Cloth")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct ClothCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ClothCreationView(type: "Coats")
    }
}
