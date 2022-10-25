//
//  ski_resortApp.swift
//  ski-resort
//
//  Created by Madison Isfan on 10/25/22.
//

import SwiftUI

@main
struct ski_resortApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
