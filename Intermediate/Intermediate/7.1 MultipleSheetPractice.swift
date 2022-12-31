//
//  MultipleSheetPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct RandomModel2: Identifiable {
    let id = UUID()
    let title: String
}

struct NextScreen2: View {
    
    let selectedModel: RandomModel2
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetPractice2: View {
    
    @State var selectedModel: RandomModel2? = nil
    @State var showSheet = false
    @State var showSheet2 = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                //showSheet.toggle()
                selectedModel = RandomModel2(title: "Button 1")
            } label: {
                Text("Button 1")
            }

            Button {
                //showSheet2.toggle()
                selectedModel = RandomModel2(title: "Button 2")
            } label: {
                Text("Button 2")
            }
        }
        //.sheet(isPresented: $showSheet) {
        //    NextScreen2(selectedModel: RandomModel2(title: "Button 1"))
        //}
        //.sheet(isPresented: $showSheet2) {
        //    NextScreen2(selectedModel: RandomModel2(title: "Button 2"))
        //}
        .sheet(item: $selectedModel) { model in
            NextScreen2(selectedModel: model)
        }
    }
}

struct MultipleSheetPractice2_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetPractice2()
    }
}
