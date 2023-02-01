//
//  CloudKitPushNotificationView.swift
//  Advanced
//
//  Created by yeonBlue on 2023/02/01.
//

import SwiftUI
import CloudKit

class CloudCloudKitPushNotificationViewViewModel: ObservableObject {
 
    
    func requestNotificationPermission() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
    
        UNUserNotificationCenter.current().requestAuthorization(options: option) { success, error in
            if let error = error {
                print(error)
            } else if success {
                print("Notification Permission Success")
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications() // main thread에서 실행되어야 함
                }
               
            } else {
                print("Notification Permission failed")
            }
        }
    }
    
    func subscribeToNotification() {
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(
            recordType: "Fruits",
            predicate: predicate,
            subscriptionID: "fruit_added_to_database",
            options: .firesOnRecordCreation // DB 추가시 발생
        )
        
        let notiInfo = CKSubscription.NotificationInfo()
        notiInfo.title = "New fruit added!"
        notiInfo.alertBody = "Open the app to check your fruits"
        notiInfo.soundName = "default"
        subscription.notificationInfo = notiInfo
        
        CKContainer.default().publicCloudDatabase.save(subscription) { subscription, error in
            if let error = error {
                print(error)
            } else {
                print("Success Subscribe Notification")
            }
        }
    }
    
    func unsubscribeNotification() {
        
        // subscribe 중인 모든 notification을 받을 수 있음
        // CKContainer.default().publicCloudDatabase.fetchAllSubscriptions(completionHandler: <#T##([CKSubscription]?, Error?) -> Void#>)
        
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "fruit_added_to_database") { returnID, error in
            if let error = error {
                print(error)
            } else {
                print("Successfully unsubscribe!")
            }
        }
    }
}

struct CloudKitPushNotificationView: View {
    
    @StateObject private var vm = CloudCloudKitPushNotificationViewViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            Button("Request Notification permission") {
                vm.requestNotificationPermission()
            }
            
            Button("Subscribe to notification") {
                vm.subscribeToNotification()
            }
            
            Button("UnSubscribe to notification") {
                vm.unsubscribeNotification()
            }
        }
    }
}

struct CloudKitPushNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitPushNotificationView()
    }
}
