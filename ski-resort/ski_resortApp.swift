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
            //HomeScreen()
            //TestingBook()
            Text("Ski Resort Finder").font(.title).fontWeight(.bold).frame(maxWidth: .infinity, maxHeight: 40).background(.black).foregroundColor(.white)
                .padding(.bottom, 20)
            SkiResortMain()
        }
        /*
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }*/
    }
}
