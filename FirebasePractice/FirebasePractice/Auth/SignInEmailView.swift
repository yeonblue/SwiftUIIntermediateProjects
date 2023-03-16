//
//  SignInEmailView.swift
//  FirebasePractice
//
//  Created by yeonBlue on 2023/03/16.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        
        Task {
            do {
                let returnUserData = try await AuthManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnUserData)
            } catch {
                print(error)
            }
        }
    }
}

struct SignInEmailView: View {
    
    @StateObject private var vm = SignInEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $vm.email)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            
            SecureField("Password", text: $vm.password)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            
            Button {
                vm.signIn()
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(minHeight: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()

        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView()
        }
    }
}
