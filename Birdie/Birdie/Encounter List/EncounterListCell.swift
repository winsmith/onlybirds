//
//  EncounterListCell.swift
//  Birdie
//
//  Created by Daniel Jilg on 08.09.22.
//

import SwiftUI

struct EncounterListCell: View {
    let encounter: Encounter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(encounter.bird?.canonicalName ?? "BIRD")
            Text(encounter.locationDisplayString ?? "No Location")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        
    }
}

