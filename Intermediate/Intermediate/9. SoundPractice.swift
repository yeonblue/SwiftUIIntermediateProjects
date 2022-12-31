//
//  SoundPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct SoundPractice: View {

    var body: some View {
        VStack {
            
            Button {
                SoundManager.instance.playSound(type: .ding)
            } label: {
                Text("Play Sound 1")
            }
        }
    }
}

struct SoundPractice_Previews: PreviewProvider {
    static var previews: some View {
        SoundPractice()
    }
}

import AVKit

class SoundManager {
    static let instance = SoundManager()
    
    enum SoundOption: String {
        case ding = "ding"
    }
    
    var player: AVAudioPlayer?
    
    func playSound(type: SoundOption) {
        guard let url = Bundle.main.url(forResource: type.rawValue, withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}
