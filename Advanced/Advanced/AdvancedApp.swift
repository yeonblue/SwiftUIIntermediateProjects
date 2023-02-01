//
//  AdvancedApp.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/05.
//

import SwiftUI

@main
struct AdvancedApp: App {
    
    let currentUserIsSignedIn: Bool
    
    init() {
        
        // edit scheme에서 argument를 넣어 다른 동작을 하도록 할 수 있음, debug scheme 등에서 사용
        // let userIsSignIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
        let userIsSignIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
        self.currentUserIsSignedIn = userIsSignIn
        
        let signInfo2 = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"]!
        print(signInfo2)
    }
    
    var body: some Scene {
        WindowGroup {
            CloudKitPushNotificationView()
            //UITestPractice(userIsSignIn: currentUserIsSignedIn)
        }
    }
}
