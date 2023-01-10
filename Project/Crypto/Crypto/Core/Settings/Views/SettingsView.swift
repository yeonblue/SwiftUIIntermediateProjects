//
//  SettingsView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/10.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let githubURL = URL(string: "https://github.com/yeonblue")!
    
    var body: some View {
        NavigationView {
            List {
                descriptionAndLinksView
                coinGeckoSection
                developerSection
                applictionSection
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton(presentaionMode: _presentaionMode)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    private var descriptionAndLinksView: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                
                Text("SwiftUI Pracetice App.\nIt uses MVVM architecture, Combine, and Core Data.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
        } header: {
            Text("Crpyto App")
        }
        .listStyle(.grouped)
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(20)
                
                Text("The crptocurrency data that is used in this app comes from a free API from CoinGekco!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            
            Group {
                Link("Visit Coingecko", destination: coingeckoURL)
            }
            .accentColor(.blue)
            
        } header: {
            Text("Coingecko")
        }
        .listStyle(.grouped)
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo-transparent")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(20)
                
                Text("This app was developed by SY. It uses SwiftUI and is written 100% in swift.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            
            Group {
                Link("My Github Link", destination: githubURL)
            }
            .accentColor(.blue)
            
        } header: {
            Text("Developer")
        }
        .listStyle(.grouped)
    }
    
    private var applictionSection: some View {
        Section {
            Group {
                Link("Terms of Service", destination: defaultURL)
                Link("Privacy Policy", destination: defaultURL)
                Link("Company Website", destination: defaultURL)
                Link("Learn more", destination: defaultURL)
            }
            .accentColor(.blue)
        } header: {
            Text("Application")
        }
    }
}
