//
//  LocationPickerView.swift
//  Birdie
//
//  Created by Daniel Jilg on 08.09.22.
//

import SwiftUI

struct LocationPickerView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    
    var body: some View {
        HStack {
            if locationViewModel.authorizationStatus == .authorizedAlways || locationViewModel.authorizationStatus == .authorizedWhenInUse {
                VStack(alignment: .leading) {
                    Text(locationViewModel.textDescription)
                    Text("\(locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0) \(locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            } else {
                LocationStatusView()
            }
        }
    }
}
