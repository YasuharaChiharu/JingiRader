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
    }
    
    let jingiData = JingiData()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            
            let current = $0.coordinate
            
            //let osaka = CLLocationCoordinate2D(latitude: 34.68639, longitude: 135.52)
            
            
            let locCalc  = LocationCalc(currentCoordinate: current)
            let maxDist:Double = jingiData.maxDistance(locationCalc: locCalc)

            self.region = MKCoordinateRegion(
                center: current,
                latitudinalMeters: maxDist * 2200,
                longitudinalMeters: maxDist * 2200
            )

        }

    }
    
    
}
