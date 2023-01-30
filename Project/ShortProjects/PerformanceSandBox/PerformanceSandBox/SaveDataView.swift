//
//  SaveDataView.swift
//  PerformanceSandBox
//
//  Created by yeonBlue on 2023/01/29.
//

import SwiftUI

class SaveData: ObservableObject {
    @Published var highscore = 0
}

struct SaveDataView: View {
    
    @StateObject @DeboucedObservedObject(delay: 0.5) var saveData = SaveData()
    
    var body: some View {
        Button("High Score: \(saveData.highscore)") {
            // saveData.wrappedValue.highscore += 1
            saveData.highscore += 1 // dynamicMemberLookUp을 추가해서 가능해짐
        }
        
        OtherView(saveData: saveData)
    }
}

struct OtherView: View {
    
    //@ObservedObject var saveData: SaveData
    @DeboucedObservedObject var saveData: SaveData
    
    var body: some View {
        Text("Your score is: \(saveData.highscore)")
    }
}

struct SaveDataView_Previews: PreviewProvider {
    static var previews: some View {
        SaveDataView()
    }
}
