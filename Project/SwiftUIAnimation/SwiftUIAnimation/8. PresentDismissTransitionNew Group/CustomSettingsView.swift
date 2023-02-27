//
//  CustomSettingsView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/27.
//

import SwiftUI

struct CustomSettingsView: View {
    
    @State private var selection = 1
    @State private var setDate = Date()
    @State private var timeZoneOverride = true
    @State private var volume: Double = 25.0
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                              
                    HStack {
                        Spacer()
                        Text("Settings")
                            .foregroundColor(.black)
                        .font(.title)
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    
                    // DatePicker
                    Section {
                        DatePicker(selection: $setDate) {
                            Image(systemName: "calendar.circle")
                        }
                        .foregroundColor(.black)
                        .listRowBackground(Color.orange)
                    } header: {
                        Text("Date And Time")
                    }

                    // time zone toggle
                    Section {
                        Toggle(isOn: $timeZoneOverride) {
                            Label("Override", systemImage: "timer")
                                .foregroundColor(.black)
                        }
                        .listRowBackground(Color.orange)
                    } header: {
                        Text("TimeZone Override")
                    }
                    
                    // alarm volumne
                    Section {
                        VStack {
                            Text("Volume \(String(format: "%.0f", volume)) Decibels")
                            Slider(value: $volume, in: 0...100) { _ in
                                // code when slider is moved
                            }
                        }
                    } header: {
                        Text("Alarm Volume")
                    }
                    .listRowBackground(Color.orange)
                    
                    // repeat alarm picker
                    Section {
                        Picker(selection: $selection) {
                            Text("No Repeat").tag(1)
                            Text("Repeat Once").tag(2)
                            Text("Repeat Twice").tag(3)
                        } label: {
                            Text("Repeat Alarm")
                        }

                    } header: {
                        Text("Repeat Alarm")
                    }
                    .listRowBackground(Color.orange)
                    .pickerStyle(.menu)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isShowing = false
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save")
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.green)
                }
                .listStyle(.insetGrouped)
            }
            .frame(width: 350, height: 620)
            .cornerRadius(20)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSettingsView(isShowing: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
