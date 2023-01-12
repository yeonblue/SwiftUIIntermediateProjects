//
//  PreferenceKeyPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/12.
//

import SwiftUI

// binding같이 보통 데이터는 parent에서 child로 흘러가는 것이 보통
// 그러나 preferenceKey를 이용하면 child에서 parent로 데이터를 보내는 것이 가능
// 대표적으로 NavigationView의 경우 child에서 navigationTitle을 지정할 수 있음
// child는 값을 가지고 있으나, parent는 가지고 있지 않을 때 쓰면 좋음
// child의 geometry를 얻고자 할 떄 보통 사용

struct PreferenceKeyPractice: View {
    
    @State private var text: String = "Hello, world!"
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text)
            }
            .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { str in
                self.text = str
            })
            .navigationTitle("Navigation Title")
        }
    }
}

struct PreferenceKeyPractice_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyPractice()
    }
}

struct SecondaryScreen: View {
    
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear {
                getDataFromDatabase()
            }
            .customTitle(newValue)
    }
    
    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.newValue = "New Value Form DB"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
   
    static var defaultValue: String = ""
    
    // value는 defaultValue인 ""로 시작
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        return self.preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}
