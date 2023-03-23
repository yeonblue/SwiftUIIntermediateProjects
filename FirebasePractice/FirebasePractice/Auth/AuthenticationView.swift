//
//  AuthenticationView.swift
//  FirebasePractice
//
//  Created by yeonBlue on 2023/03/16.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws{
        
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthManager.shared.signInWithGoogle(tokens: tokens)
    }
}

struct AuthenticationView: View {
    
    @StateObject private var vm = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(minHeight: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            GoogleSignInButton(
                viewModel: GoogleSignInButtonViewModel(scheme: .dark,
                                                       style: .wide,
                                                       state: .normal),
                action: {
                    Task {
                        do {
                            try await vm.signInGoogle()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                })
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(true))
        }
    }
}
