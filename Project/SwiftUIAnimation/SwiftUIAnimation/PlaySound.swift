//
//  PlaySound.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/23.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}
