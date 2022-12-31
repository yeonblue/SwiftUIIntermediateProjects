//
//  LocalNotificationPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct LocalNotificationPractice: View {
    var body: some View {
        VStack(spacing: 32) {
            Button {
                NotificationManager.instance.requestAuthorization()
            } label: {
                Text("Request permission")
            }
            
            Button {
                NotificationManager.instance.scheduleNotification()
            } label: {
                Text("Add Request after 5 sec")
            }
            
            Button {
                NotificationManager.instance.cancelNotification()
            } label: {
                Text("Cancel Notification")
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationPractice_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationPractice()
    }
}

import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("Success")
                }
            }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Notification Test"
        content.subtitle = "Test Subtitle"
        content.sound = .default
        content.badge = 1
        
        // trigger - time, calendar, location
        
        // 1. time
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // 2. Calendar, 아래의 경우 매일 오후 2시 0분에 Noti가 발생
        // var dateComponents = DateComponents()
        // dateComponents.hour = 14
        // dateComponents.minute = 0
        // dateComponents.weekday = 1 // 1은 sunday, 6은 friday
        // dateComponents.weekOfYear = 33 // 날짜도 지정 가능
        // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
        //                                             repeats: true)
        
        // 3. Location
        let center = CLLocationCoordinate2D(latitude: 37.335400, longitude: -122.009201)
        let region = CLCircularRegion(center: center,
                                      radius: 2000.0, // meter
                                      identifier: "Headquarters")
        region.notifyOnEntry = true // 들어갈 때 알려줌(noti)
        region.notifyOnExit = false // 니올 땐 하지 않음
        
        // CoreLocation import 필요
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        
        // 이미 전달 된, 전달 될 notification을 모두 제거
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
