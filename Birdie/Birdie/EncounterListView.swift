//
//  EncounterLisViewt.swift
//  Birdie
//
//  Created by Daniel Jilg on 07.09.22.
//

import SwiftUI

struct EncounterListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Encounter.timestamp, ascending: false)],
        animation: .default)
    private var encounters: FetchedResults<Encounter>

    var body: some View {
        NavigationView {
            List {
                ForEach(encounters) { item in
                    NavigationLink {
                        Text(item.timestamp ?? Date(), style: .relative)
                    } label: {
                        Text(item.timestamp ?? Date(), style: .relative)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { encounters[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct EncounterList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterListView()
    }
}
