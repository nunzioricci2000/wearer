//
//  WearerApp.swift
//  Wearer
//
//  Created by Nunzio Ricci on 12/01/23.
//

import SwiftUI

@main
struct WearerApp: App {
    @State var dataController = DataController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                //.preferredColorScheme(.light)
        }
    }
}
