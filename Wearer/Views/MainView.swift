//
//  MainView.swift
//  Wearer
//
//  Created by Pietro Ciuci on 12/01/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack  {
            TopWeather()
            BottomSheetView(isOpen: .constant(true), maxHeight: 520) {
                //Rectangle().fill(Color.red)
                //.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    Text("Today's Suggestions")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .padding(.horizontal)
                    
                    GeometryReader { geometry in
                        VStack{
                            HStack{
                                Spacer()
                                Image("sweater")
                                    .resizable()
                                    .frame(width: geometry.size.width*0.40)
                                    .frame(height: geometry.size.width*0.40)
                                    .scaledToFill()
                                    .cornerRadius(22)
                                Spacer()
                                Image("t-shirt")
                                    .resizable()
                                    .frame(width: geometry.size.width*0.40)
                                    .frame(height: geometry.size.width*0.40)
                                    .scaledToFill()
                                    .cornerRadius(22)
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            HStack {
                                Spacer()
                                Image("jeans")
                                    .resizable()
                                    .frame(width: geometry.size.width*0.40)
                                    .frame(height: geometry.size.width*0.40)
                                    .scaledToFill()
                                    .cornerRadius(22)
                                Spacer()
                                Image("shoes")
                                    .resizable()
                                    .frame(width: geometry.size.width*0.40)
                                    .frame(height: geometry.size.width*0.40)
                                    .scaledToFill()
                                    .cornerRadius(22)
                                Spacer()
                                
                            }
                            Spacer()
                        }
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
