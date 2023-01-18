//
//  UITestPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/17.
//

import SwiftUI

class UITestPractiveViewModel: ObservableObject {
    
    @Published var textFieldText: String = ""
    let placeholderText: String = "Add your name..."
    
    @Published var currentUserIsSignedIn: Bool
    
    init(currentUserIsSignedIn: Bool) {
        self.currentUserIsSignedIn = currentUserIsSignedIn
    }
    
    func signUpButtonTapped() {
        guard !textFieldText.isEmpty else { return }
        
        currentUserIsSignedIn = true
    }
}

struct UITestPractice: View {
    
    @StateObject var vm: UITestPractiveViewModel
    
    init(userIsSignIn: Bool) {
        self._vm = StateObject(wrappedValue: UITestPractiveViewModel(currentUserIsSignedIn: userIsSignIn))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ZStack {
                if vm.currentUserIsSignedIn {
                    SignedInHomeView()
                        .transition(.move(edge: .trailing))
                } else {
                    signUpLayerView
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

struct UITestPractice_Previews: PreviewProvider {
    static var previews: some View {
        UITestPractice(userIsSignIn: false)
    }
}

extension UITestPractice {
    
    private var signUpLayerView: some View {
        VStack {
            TextField(vm.placeholderText, text: $vm.textFieldText)
                .font(.headline)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SignUpTextField") // UITest 등에서 특정하기 위함
            
            Button {
                withAnimation(.spring()) {
                    vm.signUpButtonTapped()
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    .accessibilityIdentifier("SignUp")
            }

        }
        .padding()
    }
}

struct SignedInHomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show welcome alert!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("ShowAlertButton")
                .alert("Welcome to the app!", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        
                    }
                }
                
                NavigationLink {
                    Text("Destination")
                } label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("NavigationLinkDestination")
            }
            .navigationTitle("Welcome")
            .padding()
        }
    }
}
