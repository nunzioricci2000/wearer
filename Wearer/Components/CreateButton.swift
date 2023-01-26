//
//  CreateButtonm.swift
//  Wearer
//
//  Created by Alberto Mura on 24/01/23.
//

import SwiftUI

struct CreateButton: View {
    var body: some View {
        Button {}
    label: {
        Text("Create")
            .font(.title2)
            .bold()
            .foregroundColor(.blue)
            .frame(width: 400, height: 70)
            .background(Color(.systemGray6))
            .cornerRadius(20)
        }
    }
}
struct CreateButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateButton()
    }
}
