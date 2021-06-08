//
//  JIngiData.swift
//  JingiRader
//
//  Created by Chiharu Yasuhara on R 3/06/08.
//

import SwiftUI
import MapKit

// スポットの構造体
struct Spot: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

public struct JingiData {
    
    let jingiList = [
        Spot(name: "八咫鏡",
             symbol:"dot.arrowtriangles.up.right.down.left.circle",
             latitude: 34.4549588, longitude: 136.7251689),
        Spot(name: "天叢雲剣",
             symbol:"paintbrush.pointed.fill",
             latitude: 35.1273705, longitude: 136.90868),
        Spot(name: "八尺瓊勾玉",
             symbol:"flame.fill",
             latitude: 35.67768462493625, longitude: 139.7254372422649)
    ]
    
    func directory(angle: Int) -> String {
        
        let dirStr: [String] = [
            "北", "北北東","北東","東北東",
            "東","東南東","南東","南南東",
            "南","南南西","南西","西南西",
            "西","西北西","北西","北北西"
        ]
        
        let hoseiAngle = (angle + 12) % 360
        let dir = hoseiAngle/23
        return dirStr[dir]
    }
    
    
    func angleList(locationCalc: LocationCalc) -> [String] {
        
        let angles = [
            directory(angle: locationCalc.angle(coordinate: jingiList[0].coordinate)),
            directory(angle: locationCalc.angle(coordinate: jingiList[1].coordinate)),
            directory(angle: locationCalc.angle(coordinate: jingiList[2].coordinate))
        ]
        
        return angles
    }
    
    func distList(locationCalc: LocationCalc) -> [Double] {
        
        let distances = [
            locationCalc.distance(coordinate: jingiList[0].coordinate),
            locationCalc.distance(coordinate: jingiList[1].coordinate),
            locationCalc.distance(coordinate: jingiList[2].coordinate),
        ]

        return distances
    }
    
    func maxDistance(locationCalc: LocationCalc) -> Double {
                
        let distList = self.distList(locationCalc: locationCalc)
        
        var maxDist:Double = 0.0
        for dist in distList {
            if maxDist < dist { maxDist = dist }
        }
        
        return maxDist
    }
    
}
