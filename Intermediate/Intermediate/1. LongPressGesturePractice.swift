//
//  LongPressGesturePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/30.
//

import SwiftUI

struct LongPressGesturePractice: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        // Text(isComplete ? "Completed" : "Not Complete")
        //     .padding()
        //     .background(isComplete ? .green : .gray)
        //     .cornerRadius(10)
        //     .onLongPressGesture(minimumDuration: 1.0,
        //                         maximumDistance: 15.0, // 누르고 어느정도 벗어나도 되는지?
        //                         perform: {
        //         isComplete.toggle()
        //     }
        
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 50)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Click Here")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                        
                        // minDuration 이후
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    } onPressingChanged: { isPressing in
                        
                        // 누르고 있는 동안
                        if isPressing {
                            withAnimation(.easeOut(duration: 1.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeOut(duration: 1.0)) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    }
                
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isSuccess = false
                        isComplete = false
                    }
            }
        }
    }
}

struct LongPressGesturePractice_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesturePractice()
    }
}
