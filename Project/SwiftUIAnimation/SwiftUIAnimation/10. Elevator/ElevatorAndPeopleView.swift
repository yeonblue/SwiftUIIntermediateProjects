//
//  ElevatorAndPeopleView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/28.
//

import SwiftUI

struct ElevatorAndPeopleView: View {
    
    @Binding var doorsOpened: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                
                // image elevator scene
                Image("inside")
                    .resizable()
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
                
                // people
                ZStack {
                    Image("man")
                        .resizable()
                        .frame(maxWidth: geo.size.width - 250, maxHeight: geo.size.height - 300)
                        .shadow(color: .black, radius: 30, x: 5, y: 5)
                        .offset(x: geo.size.width / 3, y: 250)
                    
                    Image("man2")
                        .resizable()
                        .frame(maxWidth: geo.size.width - 150, maxHeight: geo.size.height - 280)
                        .shadow(color: .black, radius: 30, x: 5, y: 5)
                        .offset(x: 40, y: 230)
                    
                    Image("man3")
                        .resizable()
                        .frame(maxWidth: geo.size.width - 170, maxHeight: geo.size.height - 250)
                        .shadow(color: .black, radius: 30, x: 5, y: 5)
                        .offset(x: 180, y: 255)
                    
                    Image("man4")
                        .resizable()
                        .frame(maxWidth: geo.size.width - 200, maxHeight: geo.size.height - 300)
                        .shadow(color: .black, radius: 30, x: 5, y: 5)
                        .offset(x: -40, y: 250)
                }
                
                // add doors
                HStack {
                    Image("leftDoor")
                        .resizable()
                        .offset(x: doorsOpened ? -geo.size.width / 2 : 4)
                    
                    Image("rightDoor")
                        .resizable()
                        .offset(x: doorsOpened ? geo.size.width / 2 : -4)
                }
                
                Image("doorFrame")
                    .resizable()
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
            }
            .animation(.easeInOut.speed(0.1).delay(0.3), value: doorsOpened) // speed가 1이면 1초, 0.1이면 10초간 실행
        }
    }
}

struct ElevatorAndPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        ElevatorAndPeopleView(doorsOpened: .constant(false))
    }
}
