//
//  DisplayingView.swift
//  PerformanceSandBox
//
//  Created by yeonBlue on 2023/01/30.
//

import SwiftUI

// swiftui - 값이 바뀌면 전체를 매번 새로 그림(view가 struct로 되어있어서 가능)
// 하지만 복잡한 뷰일 경우 좀 더 최적화가 필요
// Observe가 필요한지 좀 더 고민을 하며 사용을 하면 좋을 듯함

struct DisplayingView: View {
    
    @EnvironmentObject var saveData: SaveData
    
    var body: some View {
        print("DisplayingView") // EnviromentObject를 통해 읽고 있는 여기만 매번 reload됨
        return Text("Your high score is \(saveData.highscore)")
    }
    
    init() {
        print("DisplayingView.init")
    }
}

// 아래 View는 read는 필요없고, write만 필요
// Enviroment는 Value 타입
// EnviromentObject는 referenceType
struct UpdateingView: View {
    
    //@EnvironmentObject var saveData: SaveData
    @Environment(\.saveData) var saveData
    
    var body: some View {
        print("UpdateingView")
        return Button("Add to HighScore") {
            saveData.highscore += 1
        }
    }
    
    init() {
        print("UpdateingView.init")
    }
}

// State: 전체가 바뀌면 변화를 감지, class의 일부가 바뀌는 것은 감지하지 않음
// StateObject: 내부에 한 property가 변해도 이를 감지

struct SampleContentView: View {
    
    //@StateObject var saveData = SaveData() // StateObject로 선언했으므로 바뀔 떄마다 매번 새로 그림
    @State var saveData = SaveData()
    
    var body: some View {
        print("SampleContentView")
        return VStack {
            DisplayingView()
            UpdateingView()
        }
        .environmentObject(saveData) // observe read, write
        .environment(\.saveData, saveData) // only write data
    }
    
    init() {
        print("SampleContentView.init")
    }
}

struct SaveDatakey: EnvironmentKey {
    static var defaultValue = SaveData()
}

extension EnvironmentValues {
    var saveData: SaveData {
        get {
            self[SaveDatakey.self]
        } set {
            self[SaveDatakey.self] = newValue
        }
    }
}

struct DisplayingView_Previews: PreviewProvider {
    static var previews: some View {
        SampleContentView()
    }
}
