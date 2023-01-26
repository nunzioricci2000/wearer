//
//  Title.swift
//  Wearer
//
//  Created by Nunzio Ricci on 16/01/23.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
                .font(.system(size: 28, weight: .semibold, design: .rounded))
            Spacer()
        }.padding([.horizontal, .top])
    }
}

extension Text {
    func title() -> some View {
        modifier(Title())
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Text("Title")
            .title()
    }
}
