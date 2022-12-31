//
//  MultipleSheetPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID()
    let title: String
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetPractice: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "Starting")
    @State var showSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                selectedModel = RandomModel(title: "Button 1")
                showSheet.toggle()
            } label: {
                Text("Button 1")
            }

            Button {
                selectedModel = RandomModel(title: "Button 2")
                showSheet.toggle()
            } label: {
                Text("Button 2")
            }
        }
        .sheet(isPresented: $showSheet) {
            
            // sheet modifier가 추가 될 때 content가 구성
            // 따라서 맨 처음은 Starting이 나타남
            // Binding을 쓰거나, multiple .sheets, $item을 사용해서 해결 가능
            NextScreen(selectedModel: selectedModel)
        }
    }
}

struct MultipleSheetPractice_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetPractice()
    }
}
