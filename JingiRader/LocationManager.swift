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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            self.region.center = $0.coordinate

            if self.region.span.latitudeDelta < 0.01 {
                self.region.span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
            }
            
//            let center = CLLocationCoordinate2D(
//                latitude: $0.coordinate.latitude,
//                longitude: $0.coordinate.longitude)
            
            
            
            
//            let locCalc = LocationCalc(latitude: center.latitude, longitude: center.longitude)
//            let maxDist:Double = locCalc.maxDistance()
//
//            self.region = MKCoordinateRegion(
//                center: center,
//                latitudinalMeters: maxDist * 2200,
//                longitudinalMeters: maxDist * 2200
//            )


        }

    }
    
    
}
