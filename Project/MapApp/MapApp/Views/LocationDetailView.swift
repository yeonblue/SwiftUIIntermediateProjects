//
//  LocationDetailView.swift
//  MapApp
//
//  Created by yeonBlue on 2023/02/08.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            imageSectionView
                .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
            
            Divider()
            
            titleSectionView
            descriptionSectionView
            
            Divider()
            
            mapLayerView
        }
        .ignoresSafeArea()
        .background(.thinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

extension LocationDetailView {
    
    private var imageSectionView: some View {
        VStack {
            TabView {
                ForEach(location.imageNames, id: \.self) { imgName in
                    Image(imgName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                        .clipped()
                }
            }
            .frame(height: 500)
            .tabViewStyle(.page)
        }
    }
    
    private var titleSectionView: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(location.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(location.cityName)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
    
    private var descriptionSectionView: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(location.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let url = URL(string: location.link) {
                    Link("Read more on Wikipedia", destination: url)
                        .font(.headline)
                        .tint(.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
    
    private var mapLayerView: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        ),
            annotationItems: [location]) { loc in
            MapAnnotation(coordinate: loc.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
        .allowsHitTesting(false) // drag, 터치 불가
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
