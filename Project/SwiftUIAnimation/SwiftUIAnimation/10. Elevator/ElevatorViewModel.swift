//
//  ElevatorViewModel.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/28.
//

import SwiftUI

class ElevatorViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var doorsOpened = false
    @Published var floor1 = false
    @Published var floor2 = false
    @Published var goingUp = false
    
    @Published var doorOpenTimer: Timer? = nil
    @Published var chimesTimer: Timer? = nil
    @Published var doorSoundTimer: Timer? = nil
    
    func openDoors() {
        doorOpenTimer = Timer.scheduledTimer(withTimeInterval: 8, repeats: false, block: { _ in
            self.doorsOpened.toggle()
        })
    }
    
    func playChimeSound() {
        chimesTimer = Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false, block: { _ in
            playSound(sound: "elevatorChime", type: "m4a")
        })
    }
    
    func playDoorOpenCloseSound(interval: TimeInterval) {
        chimesTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { _ in
            playSound(sound: "doorsOpenClose", type: "m4a")
        })
    }
    
    func floorNumbers() {
        
        // 1층과 2층은 서로 동시에 존재할 수 없으므로
        if !floor2 {
            floor1.toggle()
        }
        
        /// 문이 열렸는지 체크
        if !doorsOpened {
            openDoors()
            playChimeSound()
            
            /// 올라가는 중이라면 4초 대기(delay) 후 2층 불을 킴, 그리고 1층불을 끔, default는 단순히 fade-in, out을 수행
            if goingUp {
                withAnimation(.default.delay(4.0)) {
                    floor2 = true
                    floor1 = false
                }
                withAnimation(.default.delay(5.0)) {
                    floor1 = true
                    floor2 = false
                    playDoorOpenCloseSound(interval: 8.5)
                }
            } else if !goingUp {
                withAnimation(.default.delay(5.0)) {
                    floor1 = true
                    floor2 = false
                    playDoorOpenCloseSound(interval: 8.5)
                }
                withAnimation(.default.delay(5.0)) {
                    floor2 = true
                    floor1 = false
                }
            }
        }
    }
    
    func stopTimers () {
        doorOpenTimer?.invalidate()
        doorOpenTimer = nil
        
        chimesTimer?.invalidate()
        chimesTimer = nil
        
        doorSoundTimer?.invalidate()
        doorSoundTimer = nil
    }
}
