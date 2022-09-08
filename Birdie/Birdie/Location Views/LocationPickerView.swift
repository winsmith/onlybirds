//
//  LocationPickerView.swift
//  Birdie
//
//  Created by Daniel Jilg on 08.09.22.
//

import SwiftUI

struct LocationPickerView: View {
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        
        if locationViewModel.authorizationStatus == .authorizedAlways || locationViewModel.authorizationStatus == .authorizedWhenInUse {
            VStack {
                HStack {
                    Text(locationViewModel.currentPlacemark?.administrativeArea ?? "")
                    Text(locationViewModel.currentPlacemark?.country ?? "")
                }
                
                HStack {
                    Text("\(locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0)")
                    Text("\(locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
        } else {
            LocationStatusView()
        }
        
    }
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView()
    }
}
