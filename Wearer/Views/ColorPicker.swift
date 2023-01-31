//
//  HelloWorld.swift
//  Wearer
//
//  Created by Pietro Ciuci on 30/01/23.
//

import SwiftUI

struct ColorPicker: View {
    let colors: [String] = ["Black", "Brown", "Yellow", "White", "Blue", "Green", "Orange", "Red", "Pink"]
    var body: some View {
        List {
            ForEach(colors, id: \.self) { color in
                HStack {
                    if color == "White" {
                        Circle()
                            .strokeBorder(Color.black)
                            .frame(width: 15)
                    } else {
                        Circle()
                            .fill(Color(color))
                            .frame(width: 15)
                    }
                    Text(color)
                }
            }
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker()
    }
}
