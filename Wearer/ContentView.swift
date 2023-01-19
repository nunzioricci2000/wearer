//
//  ContentView.swift
//  Wearer
//
//  Created by Nunzio Ricci on 12/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let omService = OMService()
        MainView(viewModel: OMViewModel(omService: omService))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
