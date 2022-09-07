//
//  BirdSelector.swift
//  Birdie
//
//  Created by Daniel Jilg on 07.09.22.
//

import SwiftUI

struct BirdSelector: View {
    @State var query = ""
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bird.canonicalName, ascending: true)],

        animation: .default)
    private var filteredBirds: FetchedResults<Bird>

    var body: some View {
        VStack {
            TextField("Bird Name", text: $query)
                .onChange(of: query) { value in
                    filteredBirds.nsPredicate = query.isEmpty
                        ? nil
                    : NSPredicate(format: "canonicalName CONTAINS[cd] %@", value.lowercased())
                }
            List(filteredBirds, id: \.self) { bird in
                Button(bird.canonicalName ?? "–") {
                    let encounter = Encounter(context: viewContext)
                    encounter.timestamp = Date()
                    encounter.bird = bird
                    try! viewContext.save()
                }
            }
        }
    }
}

struct BirdSelector_Previews: PreviewProvider {
    static var previews: some View {
        BirdSelector()
    }
}
