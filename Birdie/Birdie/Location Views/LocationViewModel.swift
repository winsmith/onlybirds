// https://www.andyibanez.com/posts/using-corelocation-with-swiftui/

import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    
    private let locationManager: CLLocationManager
    
    @Published var textDescription: String = ""
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        fetchCountryAndCity(for: locations.first)
        textDescription = concatenateTextDescription()
    }

    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            self.currentPlacemark = placemarks?.first
        }
    }
    
    func concatenateTextDescription() -> String {
        let adminArea = currentPlacemark?.administrativeArea
        let country = currentPlacemark?.country
            
        if let adminArea, let country {
            return "\(adminArea), \(country)"
        }
            
        if let adminArea {
            return adminArea
        }
            
        if let country {
            return country
        }
            
        return "No Location"
    }
}
