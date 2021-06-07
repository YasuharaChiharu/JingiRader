//
//  LocationCalc.swift
//  JingiRader
//
//  Created by Chiharu Yasuhara on R 3/06/06.
//

import Foundation
import CoreLocation

class LocationCalc: NSObject {
    var currentLatitude: Double
    var currentLongitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.currentLatitude = latitude
        self.currentLongitude = longitude
    }
    
    
    func maxDistance() -> Double {
        
        let points = [
            CLLocationCoordinate2D(latitude: 34.4549588, longitude: 136.7251689),
            CLLocationCoordinate2D(latitude: 35.1273705, longitude: 136.90868),
            CLLocationCoordinate2D(latitude: 35.67768462493625, longitude: 139.7254372422649)
        ]
        
        var maxDist:Double = 0.0
        
        for point in points {
            let dist = distance(coordinate: point)
            if maxDist < dist { maxDist = dist }
        }
        
        return maxDist
    }
    
    // 基準地の緯度経度から目的地の緯度経度の方角を計算する
//    func angle(targetLatitude: Double, targetLongitude: Double) -> Int {
    func angle(coordinate: CLLocationCoordinate2D) -> Int {
        
        let targetLatitude = coordinate.latitude
        let targetLongitude = coordinate.longitude
        
        let currentLatitude     = toRadian(currentLatitude)
        let currentLongitude    = toRadian(currentLongitude)
        let targetLatitudeR      = toRadian(targetLatitude)
        let targetLongitudeR     = toRadian(targetLongitude)
        
        let difLongitude = targetLongitudeR - currentLongitude
        let y = sin(difLongitude)
        let x = cos(currentLatitude) * tan(targetLatitudeR) - sin(currentLatitude) * cos(difLongitude)
        let p = atan2(y, x) * 180 / Double.pi
        
        if p < 0 {
            return Int(360 + atan2(y, x) * 180 / Double.pi)
        }
        return Int(atan2(y, x) * 180 / Double.pi)
    }
    // 角度からラジアンに変換
    func toRadian(_ angle: Double) -> Double {
        return angle * Double.pi / 180
    }
    
    //    func distance(targetLatitude: Double, targetLongitude: Double) -> Double {
    func distance(coordinate: CLLocationCoordinate2D) -> Double {

        let targetLatitude = coordinate.latitude
        let targetLongitude = coordinate.longitude
        
        // 緯度経度をラジアンに変換
        let currentLatitudeR     = toRadian(currentLatitude)
        let currentLongitudeR    = toRadian(currentLongitude)
        let targetLatitudeR      = toRadian(targetLatitude)
        let targetLongitudeR     = toRadian(targetLongitude)
        
        // 赤道半径
        let equatorRadius = 6378137.0;
        
        // 算出
        let averageLat = (currentLatitudeR - targetLatitudeR) / 2
        let averageLon = (currentLongitudeR - targetLongitudeR) / 2
        let distance = equatorRadius * 2 * asin(sqrt(pow(sin(averageLat), 2) + cos(currentLatitudeR) * cos(targetLatitudeR) * pow(sin(averageLon), 2)))
        
        return distance / 1000
    }
    
}
