//
//  ContentView.swift
//  JingiRader
//
//  Created by Chiharu Yasuhara on R 3/06/06.
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

struct ContentView: View {
    
    @ObservedObject var manager = LocationManager()
    @State var trackingMode = MapUserTrackingMode.none
    
    let spotList = [
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
    
    var body: some View {
        
        
        let heading = $manager.heading.wrappedValue
        
        let locCalc = LocationCalc(
            latitude: $manager.region.center.latitude.wrappedValue,
            longitude: $manager.region.center.longitude.wrappedValue)

        let angles = [
            directory(angle: locCalc.angle(coordinate: spotList[0].coordinate)),
            directory(angle: locCalc.angle(coordinate: spotList[1].coordinate)),
            directory(angle: locCalc.angle(coordinate: spotList[2].coordinate))
        ]
        let distances = [
            locCalc.distance(coordinate: spotList[0].coordinate),
            locCalc.distance(coordinate: spotList[1].coordinate),
            locCalc.distance(coordinate: spotList[2].coordinate),
        ]
        
        VStack{

            Spacer()

            HStack{
                Image(systemName: spotList[0].symbol).foregroundColor(.red)
                Text("\(spotList[0].name)")
            }
            Text("距離： \(distances[0])㎞  方向： \(angles[0])")
            Spacer()
            HStack{
                Image(systemName: spotList[1].symbol).foregroundColor(.red)
                Text("\(spotList[1].name)")
            }
            Text("距離： \(distances[1])㎞  方向： \(angles[1])")
            Spacer()
            HStack{
                Image(systemName: spotList[2].symbol).foregroundColor(.red)
                Text("\(spotList[2].name)")
            }
            Text("距離： \(distances[2])㎞  方向： \(angles[2])")
            

            Map(coordinateRegion: $manager.region,
                interactionModes: MapInteractionModes.zoom,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: spotList,
                annotationContent: { spot in
                    MapAnnotation(coordinate: spot.coordinate,
                                  anchorPoint: CGPoint(x: 0.5, y: 0.5), content: {
                                    Image(systemName: spot.symbol).foregroundColor(.red)
                                    Text(spot.name).bold().foregroundColor(.red)
                                  })
                }
            ).clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .padding(40)
            .edgesIgnoringSafeArea(.bottom)
            .rotationEffect(Angle(degrees: 360.0-heading))
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
