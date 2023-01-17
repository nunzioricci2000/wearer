//
//  Semimodal.swift
//  Wearer
//
//  Created by Nunzio Ricci on 17/01/23.
//

import SwiftUI

struct Semimodal<Back: View, Front: View>: View {
    var back: () -> Back
    var front: () -> Front
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
/*
struct Semimodal_Previews: PreviewProvider {
    static var previews: some View {
        Semimodal()
    }
}
*/
extension View {
    
}
