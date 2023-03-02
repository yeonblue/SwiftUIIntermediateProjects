//
//  WeatherPickerView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/02.
//

import SwiftUI

struct WeatherPickerView: View {
    
    @Binding var pickerSelection: Int
    
    var body: some View {
        Picker(selection: self.$pickerSelection, label: Text("WeatherPickerView")) {
            Text("Temperature 🌡").tag(0)
            Text("Precipitation 🌧").tag(1)
            Text("Wind 💨").tag(2)
        }
        .labelsHidden()
        .pickerStyle(.segmented)
        .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 2)
                        .shadow(color: Color.black, radius: 8, x: 0, y: 0))
        .cornerRadius(8)
        .padding(.horizontal, 10)
        .padding(.bottom, 15)
    }
}

struct WeatherPickerView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPickerView(pickerSelection: .constant(2))
    }
}
