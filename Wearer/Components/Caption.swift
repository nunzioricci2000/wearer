//
//  Caption.swift
//  Wearer
//
//  Created by Alberto Mura on 31/01/23.
//

import SwiftUI

struct Caption: View {
    @State var text: String
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
}

struct Caption_Previews: PreviewProvider {
    static var previews: some View {
        Caption(text: "Caption")
    }
}
