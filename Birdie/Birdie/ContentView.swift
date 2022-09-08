//
//  ContentView.swift
//  Birdie
//
//  Created by Daniel Jilg on 07.09.22.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bird.canonicalName, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Bird>

    var body: some View {
        TabView {
            LogEncounterView()
                .tabItem {
                    Label("Add", systemImage: "plus")
                }

            EncounterListView()
                .tabItem {
                    Label("Encounters", systemImage: "list.dash")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
