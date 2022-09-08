//
//  LogEncounterView.swift
//  Birdie
//
//  Created by Daniel Jilg on 07.09.22.
//

import SwiftUI

struct LogEncounterView: View {
    @State var query = ""
    @FocusState var textFieldIsFocused: Bool
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bird.canonicalName, ascending: true)],

        animation: .default)
    private var filteredBirds: FetchedResults<Bird>

    var body: some View {
        List {
            Section("Filter") {
                TextField("Bird Name", text: $query)
                    .focused($textFieldIsFocused)
                    .onChange(of: query) { value in
                        filteredBirds.nsPredicate = query.isEmpty
                            ? nil
                            : NSPredicate(format: "canonicalName CONTAINS[cd] %@", value.lowercased())
                    }
            }

            Section("Birds") {
                ForEach(filteredBirds, id: \.self) { bird in
                    Button(bird.canonicalName ?? "–") {
                        let encounter = Encounter(context: viewContext)
                        encounter.timestamp = Date()
                        encounter.bird = bird
                        try! viewContext.save()
                    }
                }
            }
        }
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.textFieldIsFocused = true
          }
        }
    }
}

struct BirdSelector_Previews: PreviewProvider {
    static var previews: some View {
        LogEncounterView()
    }
}
