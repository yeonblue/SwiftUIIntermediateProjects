//
//  Elevator.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/27.
//

import SwiftUI

struct Elevator: View {
    
    @StateObject private var viewModel: ElevatorViewModel
    let backgroundColor: Color = .black
    
    init(viewModel: ElevatorViewModel = ElevatorViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            ElevatorAndPeopleView(doorsOpened: $viewModel.doorsOpened)
            
            GeometryReader { geo in
                Button {
                    viewModel.stopTimers()
                    viewModel.playDoorOpenCloseSound(interval: 0.5)
                    viewModel.doorsOpened.toggle()
                    viewModel.goingUp.toggle()
                    viewModel.floorNumbers()
                } label: {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(viewModel.doorsOpened ? .white : .black)
                        .overlay(
                            Circle()
                                .stroke(.red, lineWidth: 1)
                        )
                        .padding(5)
                        .background(.black)
                        .cornerRadius(20)
                }
                .position(x: geo.size.width / 33, y: geo.size.height / 2)
                
                HStack {
                    Image(systemName: "1.circle")
                        .foregroundColor(viewModel.floor1 ? .red : .black)
                        .opacity(viewModel.floor1 ? 1 : 0.3)
                    
                    Image(systemName: "2.circle")
                        .foregroundColor(viewModel.floor2 ? .red : .black)
                        .opacity(viewModel.floor2 ? 1 : 0.3)
                }
                .position(x: geo.size.width / 2, y: geo.size.height * 0.02 + 2)
            }
        }
    }
}

struct Elevator_Previews: PreviewProvider {
    static var previews: some View {
        Elevator()
    }
}

/*
 position??? ?????? ????????? ???????????? ??? ???????????? ???????????????.
 ??? ????????? ?????? ?????? ???????????? ??? ????????? ????????? ??????????????? ???????????????.
 
 SwiftUI?????? position??? ?????? ??????????????? ?????? ????????? ?????? ?????? ????????? ???????????? ???????????? ?????? ?????? ?????? ??????????????? ????????? ?????? ????????????.
 
 position??? ?????? ????????? ???????????? ??????????????? ???????????? ??? ????????????,
 offset??? ?????? ????????? ???????????? ??????????????? ???????????? ??? ???????????????.
 ???, position??? ?????? ???????????? ?????? ?????? ?????? ????????????????????? ?????? ????????? ???????????? ??????, o
 ffset??? ?????? ?????? ???????????? ???????????? ?????? ???????????? ?????? ??????????????????.
 
 VStack {
     Text("Hello, World!")
         .position(x: 100, y: 100)
     Text("Hello, SwiftUI!")
         .offset(x: 50, y: 50)
 }
 ??? ?????? Text ?????? position??? ???????????? ?????? ?????? ??????????????? 100pt, 100pt ????????? ????????????,
 ??? ?????? Text ?????? offset??? ???????????? ?????? ???????????? 50pt ?????????, 50pt ???????????? ???????????????.
 */
