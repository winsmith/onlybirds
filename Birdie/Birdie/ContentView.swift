//
//  ContentView.swift
//  Birdie
//
//  Created by Daniel Jilg on 07.09.22.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @State var logSheetVisible: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bird.canonicalName, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Bird>

    var body: some View {
        EncounterListView()
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Add") {
                        logSheetVisible = true
                    }
                    .sheet(isPresented: $logSheetVisible) { 
                        LogEncounterStagingView()
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
