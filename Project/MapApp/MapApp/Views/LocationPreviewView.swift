//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by yeonBlue on 2023/02/07.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                imageSectionView
                titleSectionView
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThickMaterial)
                .offset(y: 50)
        )
        .cornerRadius(10) // offset으로 인한 아래부분은 clip됨
    }
}

extension LocationPreviewView {
    private var imageSectionView: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.white, lineWidth: 6)
                    }
            }
        }
    }
    
    private var titleSectionView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            vm.sheetLocation = location
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 130, height: 44)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonTapped()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 130, height: 44)
        }
        .buttonStyle(.bordered)
    }
}


struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(LocationsViewModel())
    }
}
