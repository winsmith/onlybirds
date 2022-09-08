//
//  EncounterDetailView.swift
//  Birdie
//
//  Created by Daniel Jilg on 08.09.22.
//

import CoreLocation
import MapKit
import SwiftUI

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct EncounterDetailView: View {
    @State private var region: MKCoordinateRegion
    private let annotations: [CLLocationCoordinate2D]
    private let encounter: Encounter

    init(encounter: Encounter) {
        let coordinate = CLLocationCoordinate2D(
            latitude: encounter.locationLatitude,
            longitude: encounter.locationLongitude
        )

        self.encounter = encounter
        self.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        self.annotations = [coordinate]
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("What?").font(.footnote).foregroundColor(.gray)
                Text(encounter.bird?.canonicalName ?? "BIRD")
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("When?").font(.footnote).foregroundColor(.gray)
                Text(encounter.timestamp ?? Date.distantPast, style: .date)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("Where?").font(.footnote).foregroundColor(.gray)
                Text(encounter.locationDisplayString ?? "No Location")
            }
            .padding()
            
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: annotations) {
                MapMarker(coordinate: $0)
            }
        }
        .navigationTitle(encounter.bird?.canonicalName ?? "BIRD")
    }
}
