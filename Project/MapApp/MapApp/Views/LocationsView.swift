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
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                    .padding()
                
                Spacer()
                
                ZStack {
                    ForEach(vm.locations) { loc in
                        if vm.mapLocation == loc {
                            LocationPreviewView(location: loc)
                                .shadow(color: .black.opacity(0.5), radius: 20)
                                .padding()
                                .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                        removal: .move(edge: .leading)))
                        }
                    }
                }

            }
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
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
