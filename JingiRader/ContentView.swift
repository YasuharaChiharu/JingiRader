//
//  ContentView.swift
//  JingiRader
//
//  Created by Chiharu Yasuhara on R 3/06/06.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var manager = LocationManager()
    @State var trackingMode = MapUserTrackingMode.none
    
    let jingiData = JingiData()

    var body: some View {
        
        let locCalc = LocationCalc(currentCoordinate: $manager.region.center.wrappedValue)
        let angles = jingiData.dirList(locationCalc: locCalc)
        let compas = jingiData.angleList(locationCalc: locCalc)
        let distances = jingiData.distList(locationCalc: locCalc)
        let circleColor = (jingiData.minDistance(locationCalc: locCalc) < 10.0) ? Color.red : Color.white
        let spotList = jingiData.jingiList
        let heading = $manager.heading.wrappedValue

        VStack{

            Image("Logo").scaleEffect(0.5)
                .frame(width: 300, height: 70, alignment: .center)
                .clipped()
            HStack{
                Image(systemName: spotList[0].symbol).foregroundColor(.red)
                Text("\(spotList[0].name)").bold()
                Image(systemName: "location.north.fill")
                    .rotationEffect(Angle(degrees: Double(compas[0])-heading))
                    .foregroundColor(.red)
            }
            HStack{
                Text(String(format: "距離：%.2f ㎞　方向：" + angles[0] , distances[0] ))
            }
            Spacer()
            HStack{
                Image(systemName: spotList[1].symbol).foregroundColor(.red)
                Text("\(spotList[1].name)").bold()
                Image(systemName: "location.north.fill")
                    .rotationEffect(Angle(degrees: Double(compas[1])-heading))
                    .foregroundColor(.red)
            }
            HStack{
                Text(String(format: "距離：%.2f ㎞　方向：" + angles[1] , distances[1] ))
            }
            Spacer()
            HStack{
                Image(systemName: spotList[2].symbol).foregroundColor(.red)
                Text("\(spotList[2].name)").bold()
                Image(systemName: "location.north.fill")
                    .rotationEffect(Angle(degrees: Double(compas[2])-heading))
                    .foregroundColor(.red)

            }
            HStack{
                Text(String(format: "距離：%.2f ㎞　方向：" + angles[2] , distances[2] ))
            }

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
            .overlay(Circle().stroke(circleColor, lineWidth: 4))
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
