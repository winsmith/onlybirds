// https://www.andyibanez.com/posts/using-corelocation-with-swiftui/

import CoreLocation
import SwiftUI

struct LocationStatusView: View {
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            Button(action: {
                locationViewModel.requestPermission()
            }, label: {
                Label("Allow Location", systemImage: "location")
            })
                .environmentObject(locationViewModel)
        case .restricted:
            ErrorView(errorText: "Location use is restricted.")
        case .denied:
            ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            Text("We'll store your location in each bird encounter")
        default:
            Text("Unexpected status")
        }
    }
}

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
    }
}
