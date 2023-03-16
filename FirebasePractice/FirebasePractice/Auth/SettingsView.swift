//
//  SettingsView.swift
//  FirebasePractice
//
//  Created by yeonBlue on 2023/03/16.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    func logout() throws {
        try AuthManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @StateObject var vm = SettingsViewModel()
    @Binding var showSigninView: Bool
    
    var body: some View {
        List {
            Button("Log Out") {
                Task {
                    do {
                        try vm.logout()
                        showSigninView.toggle()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(showSigninView: .constant(true))
        }
    }
}
