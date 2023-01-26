//
//  SweatersView.swift
//  Wearer
//
//  Created by Alberto Mura on 13/01/23.
//

import SwiftUI

struct SweatersView: View {
    var body: some View {
        VStack{
            HStack {
                Text("Sweaters")
                    .fontWeight(.heavy)
                    .font(.title)
                Image(systemName: "chevron.down")
            }
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                    Rectangle()
                        .cornerRadius(30)
                        .frame(width: 165, height: 165)
                }
                    .padding(.leading)
            }
        }
    }
}
struct SweatersView_Previews: PreviewProvider {
    static var previews: some View {
        SweatersView()
    }
}
