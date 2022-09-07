//
//  BirdieApp.swift
//  Birdie
//
//  Created by Daniel Jilg on 07.09.22.
//

import SwiftUI

@main
struct BirdieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    init() {
//        let birdNameUpdater = BirdNameUpdater(with: persistenceController.container.viewContext)
//        Task {
//            try await birdNameUpdater.insertBirds(from: birdNameUpdater.urls.first!.value)
//        }
    }
}
