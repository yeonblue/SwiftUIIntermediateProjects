//
//  RecordPlayerBox.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/23.
//

import SwiftUI

struct RecordPlayerBox: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 345, height: 345)
                .cornerRadius(10)
                .foregroundColor(.black)
            
            Image("woodGrain")
                .resizable()
                .frame(width: 325, height: 325)
                .shadow(color: .white, radius: 4, x: 0, y: 0)
        }
    }
}

struct RecordPlayerBox_Previews: PreviewProvider {
    static var previews: some View {
        RecordPlayerBox()
    }
}
