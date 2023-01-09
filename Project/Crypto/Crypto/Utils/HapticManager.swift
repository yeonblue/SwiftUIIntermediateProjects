//
//  HapticManager.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/09.
//

import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        generator.notificationOccurred(type)
    }
}
