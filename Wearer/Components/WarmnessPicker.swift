//
//  WarmnessPicker.swift
//  Wearer
//
//  Created by Pietro Ciuci on 30/01/23.
//

import SwiftUI

// swiftlint:disable all

// Prende in ingresso un binding intero
struct WarmnessPicker: View {
    @Binding var rating: Int
    @Binding var isEditing: Bool
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "flame.circle.fill")
    var offColor = Color.gray
    var onColor = Color.blue
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .font(.title)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        if isEditing {
                            rating = number
                        }
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct WarmnessPicker_Previews: PreviewProvider {
    static var previews: some View {
        WarmnessPicker(rating: .constant(4), isEditing: .constant(false))
    }
}
