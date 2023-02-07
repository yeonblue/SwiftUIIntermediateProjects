//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by yeonBlue on 2023/02/06.
//

import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject {
    
    /// All loaded locations
    @Published var locations: [Location]
    
    /// Current Location on Map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    /// Current region on Map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    /// Show list of locations
    @Published var showLocationsList: Bool = false
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        updateMapRegion(location: mapLocation)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location loc: Location) {
        withAnimation(.easeInOut) {
            mapLocation = loc
            showLocationsList = false
        }
    }
}
