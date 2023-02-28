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
 position은 뷰의 위치를 지정하는 데 사용되는 속성입니다.
 이 속성은 뷰가 상위 컨테이너 뷰 내에서 어디에 배치될지를 결정합니다.
 
 SwiftUI에서 position은 뷰를 이동시키는 것이 아니라 단지 뷰의 위치를 변경하는 것이므로 다른 뷰에 대한 레이아웃에 영향을 주지 않습니다.
 
 position은 뷰의 위치를 절대적인 좌표값으로 지정하는 데 사용되고,
 offset은 뷰의 위치를 상대적인 좌표값으로 지정하는 데 사용됩니다.
 즉, position은 부모 컨테이너 뷰의 좌측 상단 모서리에서부터 뷰의 위치를 지정하는 반면, o
 ffset은 뷰의 현재 위치에서 상대적인 값을 사용하여 뷰를 이동시킵니다.
 
 VStack {
     Text("Hello, World!")
         .position(x: 100, y: 100)
     Text("Hello, SwiftUI!")
         .offset(x: 50, y: 50)
 }
 첫 번째 Text 뷰는 position을 사용하여 왼쪽 상단 모서리에서 100pt, 100pt 위치에 배치되며,
 두 번째 Text 뷰는 offset을 사용하여 현재 위치에서 50pt 아래쪽, 50pt 오른쪽에 이동합니다.
 */
