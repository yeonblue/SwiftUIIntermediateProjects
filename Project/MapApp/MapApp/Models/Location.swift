//
//  Location.swift
//  MapApp
//
//  Created by yeonBlue on 2023/02/06.
//

import SwiftUI
import MapKit

/*
 Location(
     name: "Colosseum",
     cityName: "Rome",
     coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
     description: "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum. It is the largest ancient amphitheatre ever built, and is still the largest standing amphitheatre in the world today, despite its age.",
     imageNames: [
         "rome-colosseum-1",
         "rome-colosseum-2",
         "rome-colosseum-3",
     ],
     link: "https://en.wikipedia.org/wiki/Colosseum")
*/

struct Location: Identifiable, Equatable { // Equatable이 있어야 .animation(<#T##animation: Animation?##Animation?#>, value: <#T##Equatable#>)에 사용 가능
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    var id: String { // id가 같으면 같은 Location으로 간주, 이름과 도시명이 같으면 같은 것으로 간주
        return name + cityName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}
