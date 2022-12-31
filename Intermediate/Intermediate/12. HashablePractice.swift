//
//  HashablePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct HashablePractice: View {
    
    let data: [CustomModel] = [
        CustomModel(title: "One"),
        CustomModel(title: "Two"),
        CustomModel(title: "Three"),
        CustomModel(title: "Four"),
        CustomModel(title: "Five"),
        CustomModel(title: "Six")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashablePractice_Previews: PreviewProvider {
    static var previews: some View {
        HashablePractice()
    }
}

// struct CustomModel: Identifiable { // id가 Hashable
//     let id = UUID()
//     let title: String
// }

struct CustomModel: Hashable { // id를 따로 두고 싶지 않을 경우
    let title: String
    let subtitle: String = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subtitle)
    }
}
