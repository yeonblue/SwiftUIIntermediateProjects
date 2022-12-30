//
//  DragGesturePractice2.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/30.
//

import SwiftUI

struct DragGesturePractice2: View {
    
    let startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            
            Color.green.ignoresSafeArea(.all)
            
            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                    currentDragOffsetY = 0
                                } else if endingOffsetY != 0 && currentDragOffsetY > 250 {
                                    endingOffsetY = 0
                                    currentDragOffsetY = 0
                                } else {
                                    currentDragOffsetY = 0
                                }
                            }
                        })
                )
            
            Text("\(currentDragOffsetY)")
        }
    }
}

struct DragGesturePractice2_Previews: PreviewProvider {
    static var previews: some View {
        DragGesturePractice2()
    }
}

struct SignUpView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "chevron.up")
                .padding(.top, 32)
            
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 16)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("SwiftUI Practice")
            Text("Create an Account")
                .foregroundColor(.white)
                .font(.headline)
                .padding(16)
                .background(.black)
                .cornerRadius(8)
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
        .ignoresSafeArea(edges: .bottom)
    }
}
