//
//  ClothDisplayer.swift
//  Wearer
//
//  Created by Francesco De Simone on 30/01/23.
//

import SwiftUI

struct ClothDisplayer: View {
    var picture: UIImage
    var body: some View {
        Image(uiImage: picture)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 22))
        
    }
}



struct ClothDisplayer_Previews: PreviewProvider {
    static var previews: some View {
        ClothDisplayer(picture: UIImage(named: "jeans")!)
            .frame(width: 150, height: 150)
    }
}
