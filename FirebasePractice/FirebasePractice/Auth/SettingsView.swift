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
    
    func resetPassword() async throws {
        let authUser = try AuthManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthManager.shared.resetPassword(email: email)
    }
    
    /// 테스트용, email, pw 업데이트는 새롭게 로그인을 요구
    /// This operation is sensitive and requires recent authentication. Log in again before retrying this request.
    func updateEmail() async throws {
        let email = "temp@gmail.com"
        try await AuthManager.shared.updateEmail(email: email)
    }
    
    /// 테스트용, email, pw 업데이트는 새롭게 로그인을 요구
    /// This operation is sensitive and requires recent authentication. Log in again before retrying this request.
    func updatePassword() async throws {
        let password = "tempPW123"
        try await AuthManager.shared.updatePassword(password: password)
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
            
            emailSectionView
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

extension SettingsView {
    private var emailSectionView: some View {
        Section("Email Functions") {
            Button("Reset Password") {
                Task {
                    do {
                        try await vm.resetPassword()
                        print("Password Reset Confirmed")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Update Password") {
                Task {
                    do {
                        try await vm.updatePassword()
                        print("Update Password Confirmed")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Update Email") {
                Task {
                    do {
                        try await vm.updateEmail()
                        print("Update Email Confirmed")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
