//
//  DetailView.swift
//  Wearer
//
//  Created by Pietro Ciuci on 27/01/23.
//

import SwiftUI

// swiftlint:disable all

struct ClothEditorView: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var isPresentingConfirm = false
    @State var isPresentingPhotoPicker = false
    @State var isCamera = false
    @State var isPhotoLibrary = false
    @State var cloth: Cloth
    @State var image: UIImage?
    @State var type: String
    @State var warmIndex: Int
    @State var isEditing: Bool = false
    let colors: [String] = ["Black", "Brown", "Gray", "White", "Blue", "Green", "Orange", "Red", "Pink"]
    var body: some View {
        NavigationStack {
            Form {
                if editMode?.wrappedValue.isEditing == false {
                    Section {
                        Image(uiImage: image ?? UIImage(imageLiteralResourceName: "ClothPlaceholder"))
                            .centerCropped()
                            .frame(width: 360, height: 400)
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Section(header: Text("Color")) {
                        Text(type)
                    }
                    Section(header: Text("Warmness")) {
                        WarmnessPicker(rating: $warmIndex, isEditing: $isEditing)
                    }
                    Button("Delete", role: .destructive) {
                        isPresentingConfirm.toggle()
                    }
                    .confirmationDialog("Delete item", isPresented: $isPresentingConfirm) {
                        Button("Delete", role: .destructive) {
                            moc.delete(cloth)
                            do {
                                try moc.save()
                                print("Success")
                                dismiss()
                            } catch let error as NSError {
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                } else {
                    Section {
                        Button {
                            isPresentingPhotoPicker.toggle()
                        } label: {
                            Image(uiImage: image ?? UIImage(imageLiteralResourceName: "ClothPlaceholder"))
                                .centerCropped()
                                .frame(width: 360, height: 400)
                        }
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Section {
                        Picker(selection: $type, label: Text("Color")) {
                            ForEach(colors, id: \.self) { color in
                                Text(color)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    Section(header: Text("Warmness")) {
                        WarmnessPicker(rating: $warmIndex, isEditing: $isEditing)
                    }
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
            .onChange(of: editMode?.wrappedValue.isEditing) { changes in
                if editMode?.wrappedValue.isEditing == false {
                    do {
                        cloth.picture = image?.pngData()
                        cloth.type = type
                        cloth.warmness = Int16(warmIndex)
                        isEditing = false
                        try moc.save()
                        print("Success")
                    } catch let error as NSError {
                        print("Error: \(error.localizedDescription)")
                    }
                }
                else {
                    isEditing = true
                    image = UIImage(data: cloth.picture ?? UIImage(imageLiteralResourceName: "ClothPlaceholder").pngData()!)
                    type = cloth.type ?? "Unknown"
                    warmIndex = Int(cloth.warmness)
                }
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
        }
    }
    
    func getImage() -> UIImage? {
        guard let picture = cloth.picture else { return nil }
        return UIImage(data: picture)
    }
    
    func setImage(_ image: UIImage?) {
        cloth.picture = image?.pngData()
    }
    
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
}
