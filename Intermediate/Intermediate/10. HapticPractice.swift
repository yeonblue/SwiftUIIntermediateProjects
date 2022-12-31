//
//  HapticPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct HapticPractice: View {
    var body: some View {
        VStack(spacing: 32) {
            Button {
                HapticManager.instance.notification(type: .success)
            } label: {
                Text("Notification success")
            }

            Button {
                HapticManager.instance.notification(type: .warning)
            } label: {
                Text("Notification warning")
            }
            
            Button {
                HapticManager.instance.notification(type: .error)
            } label: {
                Text("Notification error")
            }
            
            Divider().frame(height: 4)
            
            Button {
                HapticManager.instance.impact(style: .heavy)
            } label: {
                Text("Hatpic heavy")
            }
            
            Button {
                HapticManager.instance.impact(style: .medium)
            } label: {
                Text("Hatpic medium")
            }
            
            Button {
                HapticManager.instance.impact(style: .light)
            } label: {
                Text("Hatpic light")
            }
            
            Button {
                HapticManager.instance.impact(style: .rigid)
            } label: {
                Text("Hatpic rigid")
            }
            
            Button {
                HapticManager.instance.impact(style: .soft)
            } label: {
                Text("Hatpic soft")
            }
        }
        .font(.title)
    }
}

struct HapticPractice_Previews: PreviewProvider {
    static var previews: some View {
        HapticPractice()
    }
}

class HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
