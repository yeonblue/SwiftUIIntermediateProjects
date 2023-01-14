//
//  UnitTestView.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/14.
//

/*
 1. Unit Tests
 - test business logic in app
 - viewModel, dataService 등 UI와 관련되지 않은 모든 것
 
 2. UI Tests
 - tests the UI of App, user interaction
 - 사용자가 클릭하거나, 터치, UI Components
 */

import SwiftUI

struct UnitTestView: View {
    
    @StateObject private var viewModel: UnitTestViewModel
    
    init(isPremium: Bool) {
        self._viewModel = StateObject(wrappedValue: UnitTestViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.isPremium.description)
        }
    }
}

struct UnitTestView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestView(isPremium: true)
    }
}
