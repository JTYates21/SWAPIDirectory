//
//  SWAPIDirectoryApp.swift
//  SWAPIDirectory
//
//  Created by Jacek Yates on 8/21/22.
//

import SwiftUI

@main
struct SWAPIDirectoryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
