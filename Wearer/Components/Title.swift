//
//  Title.swift
//  Wearer
//
//  Created by Nunzio Ricci on 16/01/23.
//

import SwiftUI

struct Title: View {
    @State var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 28, weight: .semibold, design: .rounded))
            Spacer()
        }.padding([.horizontal, .top])
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title("Title")
    }
}
