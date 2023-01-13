//
//  MainView.swift
//  Wearer
//
//  Created by Pietro Ciuci on 12/01/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            TopWeather()
            BottomSheetView(isOpen: .constant(true), maxHeight: 480) {
                //Rectangle().fill(Color.red)
                //.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    Text("Today's Suggestions")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                    HStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray3))
                            .frame(width: 170, height: 170)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray3))
                            .frame(width: 170, height: 170)
                    }
                    HStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray3))
                            .frame(width: 170, height: 170)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray3))
                            .frame(width: 170, height: 170)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
