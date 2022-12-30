//
//  MagnificationGesturePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/30.
//

import SwiftUI

struct MagnificationGesturePractice: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        // Text("Magnification")
        //     .font(.title)
        //     .padding(40)
        //     .background(.red)
        //     .cornerRadius(10)
        //     .scaleEffect(1 + currentAmount + lastAmount)
        //     .gesture(
        //         MagnificationGesture()
        //             .onChanged({ value in
        //                 currentAmount = value - 1
        //             })
        //             .onEnded({ value in
        //                 lastAmount += currentAmount
        //                 currentAmount = 0
        //             })
        //     )
        
        VStack {
            HStack {
                Circle()
                    .fill(.pink)
                    .frame(width: 40, height: 40)
                Text("Magnification")
                Spacer()
                Image(systemName: "ellipsis")
            }
            
            Rectangle()
                .fill(.pink)
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            currentAmount = value - 1
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        })
                )
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .foregroundColor(.pink)
            
            HStack {
                Text("Caption of image")
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

struct MagnificationGesturePractice_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGesturePractice()
    }
}
