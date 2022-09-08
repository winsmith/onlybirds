//
//  LogEncounterStagingView.swift
//  Birdie
//
//  Created by Daniel Jilg on 08.09.22.
//

import SwiftUI

struct LogEncounterStagingView: View {
    @State var encounterDate: Date = .init()
    @State var encounterBirds: [Bird] = []
    @State var encounterLocation: String = ""
    
    @State var query = ""
    @FocusState var queryFieldIsFocused: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bird.canonicalName, ascending: true)],
        animation: .default
    )
    private var filteredBirds: FetchedResults<Bird>
    
    var body: some View {
        NavigationView {
            Form {
                Section("Birds encountered") {
                    if !queryFieldIsFocused {
                        ForEach(encounterBirds) { bird in
                            Text(bird.canonicalName ?? "BIRD")
                        }
                    }
                    
                    TextField("Add Bird", text: $query)
                        .submitLabel(.done)
                        .focused($queryFieldIsFocused)
                        .onChange(of: query) { value in
                            filteredBirds.nsPredicate = query.isEmpty
                                ? nil
                                : NSPredicate(format: "canonicalName CONTAINS[cd] %@", value.lowercased())
                        }
                    
                    if queryFieldIsFocused {
                        ForEach(filteredBirds, id: \.self) { bird in
                            Button(bird.canonicalName ?? "BIRD") {
                                query = ""
                                
                                withAnimation {
                                    queryFieldIsFocused = false
                                    encounterBirds.append(bird)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Encounter")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        print("Pressed")
                    }
                }
            }
        }
    }
}

struct LogEncounterStagingView_Previews: PreviewProvider {
    static var previews: some View {
        LogEncounterStagingView()
    }
}
