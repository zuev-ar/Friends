//
//  FriendsApp.swift
//  Friends
//
//  Created by Arkasha Zuev on 20.06.2021.
//

import SwiftUI

@main
struct FriendsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
