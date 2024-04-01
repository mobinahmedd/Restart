//
//  AudioPlayer.swift
//  Restart
//
//  Created by Apptycoons on 01/04/2024.
//

import Foundation
import AVFoundation //audio visual framework

var audioPlayer: AVAudioPlayer?

func playSound(sound: String,type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("Could not play the audio file")
        }
    }
}
