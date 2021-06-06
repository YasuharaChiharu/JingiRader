//
//  LocationManager.swift
//  JingiRader
//
//  Created by Chiharu Yasuhara on R 3/06/06.
//

import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var region = MKCoordinateRegion()
    @Published var heading:CLLocationDirection = 0.0
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 2
        manager.startUpdatingLocation()
        
        manager.headingFilter = kCLHeadingFilterNone
        manager.headingOrientation = .portrait
        manager.startUpdatingHeading()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.heading = newHeading.magneticHeading
//        self.heading = newHeading.trueHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLovations locations: [CLLocation]) {

        locations.last.map {

            let center = CLLocationCoordinate2D(
                latitude: $0.coordinate.latitude,
                longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            
            region = MKCoordinateRegion(center: center, span: span)

        }

    }
    
    
}
