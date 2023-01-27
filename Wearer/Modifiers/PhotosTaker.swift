//
//  PhotoTaker.swift
//  Wearer
//
//  Created by Nunzio Ricci on 26/01/23.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

struct PhotosTaker: View {
    @Binding var selectedImage: UIImage?
    init(_ image: Binding<UIImage?>) {
        _selectedImage = image
    }
    var body: some View {
        ImagePickerView(selectedImage: $selectedImage, sourceType: .camera)
            .ignoresSafeArea()
    }
}

extension View {
    func photosTaker(isPresented: Binding<Bool>, selection image: Binding<UIImage?>) -> some View {
        fullScreenCover(isPresented: isPresented) {
            PhotosTaker(image)
        }
    }
}

private struct PhotoTakerPreview: View {
    @State var isPresented: Bool = false
    @State var image: UIImage?
    var body: some View {
        Button("Show") {
            isPresented.toggle()
        }.photosTaker(isPresented: $isPresented, selection: $image)
    }
}

struct PhotoTaker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoTakerPreview()
    }
}
