//
//  CameraView.swift
//  Wearer
//
//  Created by Alberto Mura on 25/01/23.
//

import SwiftUI

struct CameraView: View {
    @Binding var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var isCameraDisplay = false
    var body: some View {
        NavigationView {
            VStack {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                } else {
                    Image("ClothPlaceholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                }
                Button("Camera") {
                    self.isCameraDisplay.toggle()
                }.padding()
                    .fullScreenCover(
                        isPresented: $isCameraDisplay ) {
                            ImagePickerView(
                                selectedImage: self.$selectedImage,
                                sourceType: .camera)
                        }
                Button("photo") {
                    self.isImagePickerDisplay.toggle()
                }.padding()
                    .sheet(isPresented: self.$isImagePickerDisplay) {
                        ImagePickerView(
                            selectedImage: self.$selectedImage,
                            sourceType: .photoLibrary)}
            }
        }
    }
}
