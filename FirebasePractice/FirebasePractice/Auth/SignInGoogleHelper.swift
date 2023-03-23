//
//  SignInGoogleHelper.swift
//  FirebasePractice
//
//  Created by yeonBlue on 2023/03/23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    
    let name: String?
    let email: String?
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        
        guard let topVC = Utils.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = signInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = signInResult.user.accessToken.tokenString
        let name = signInResult.user.profile?.name
        let email = signInResult.user.profile?.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
}
