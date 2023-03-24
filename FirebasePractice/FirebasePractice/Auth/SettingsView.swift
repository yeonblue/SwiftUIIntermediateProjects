//
//  SettingsView.swift
//  FirebasePractice
//
//  Created by yeonBlue on 2023/03/16.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadAuthProviders() {
        if let provider = try? AuthManager.shared.getProvider() {
            authProviders = provider
        }
    }
    
    func loadAuthUser() {
        self.authUser = try? AuthManager.shared.getAuthenticatedUser()
    }
    
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
    
    func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthManager.shared.linkGoogle(tokens: tokens)
        self.authUser = authDataResult
    }
    
    func linkAppleAccount() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthManager.shared.linkApple(tokens: tokens)
        self.authUser = authDataResult
    }
    
    func linkEmailAccount() async throws {
        let email = "test@gmail.com"
        let password = "test123!"
        let authDataResult = try await AuthManager.shared.linkEmail(email: email, password: password)
        self.authUser = authDataResult
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
            
            if vm.authProviders.contains(.email) {
                emailSectionView
            }
            
            if let user = vm.authUser, user.isAnonymous {
                annoymousSectionView
            }
        }
        .onAppear {
            vm.loadAuthProviders()
            vm.loadAuthUser()
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
    
    private var annoymousSectionView: some View {
        Section("Create Account") {
            Button("Link Google Account") {
                Task {
                    do {
                        try await vm.linkGoogleAccount()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Link Apple Account") {
                Task {
                    do {
                        try await vm.linkAppleAccount()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Link Email Account") {
                Task {
                    do {
                        try await vm.linkEmailAccount()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
