//
//  TabBarItem.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/13.
//

import SwiftUI

//struct TabBarItem: Hashable {
//    
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home
    case favorites
    case profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorites:
            return "Favorites"
        case .profile:
            return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .blue
        case .favorites:
            return .green
        case .profile:
            return .orange
        }
    }
}
