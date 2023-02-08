//
//  LocationsView.swift
//  MapApp
//
//  Created by yeonBlue on 2023/02/06.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForiPad: CGFloat = 640
    
    var body: some View {
        ZStack {
            mapLayerView
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                    .padding()
                    .frame(maxWidth: maxWidthForiPad)
                
                Spacer()
                
                locationPreviewView
            }
        }
        .sheet(item: $vm.sheetLocation) { loc in
            LocationDetailView(location: loc)
        }
    }
}

extension LocationsView {
    
    private var headerView: some View {
        VStack {
            
            Button {
                vm.toggleLocationsList()
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .rotationEffect(
                                Angle(degrees: vm.showLocationsList ? 180 : 0)
                            )
                            .padding()
                        , alignment: .leading)
            }
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayerView: some View {
        Map(
            coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations, // identifiable한 list(RandomAccessCollections)
            annotationContent: { loc in
                
                // MapMarker(coordinate: loc.coordinates, tint: .blue) // MapPin은 deprecated
                MapAnnotation(coordinate: loc.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == loc ? 1 : 0.6)
                        .onTapGesture {
                            vm.showNextLocation(location: loc)
                        }
                }
            }
        )
    }
    
    private var locationPreviewView: some View {
        ZStack {
            ForEach(vm.locations) { loc in
                if vm.mapLocation == loc {
                    LocationPreviewView(location: loc)
                        .shadow(color: .black.opacity(0.5), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForiPad)
                        .frame(maxWidth: .infinity) // transition이 maxWidth 부분에서 일어나므로
                        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading)))
                }
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
