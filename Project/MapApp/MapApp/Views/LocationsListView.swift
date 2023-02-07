//
//  LocationsListView.swift
//  MapApp
//
//  Created by yeonBlue on 2023/02/07.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { loc in
                
                Button {
                    vm.showNextLocation(location: loc)
                } label: {
                    listRowView(location: loc)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear) // list background가 사용되기 위함
            }
        }
        .listStyle(.plain)
    }
}

extension LocationsListView {
    private func listRowView(location loc: Location) -> some View{
        HStack {
            if let imageName = loc.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(loc.name)
                    .font(.headline)
                Text(loc.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}
