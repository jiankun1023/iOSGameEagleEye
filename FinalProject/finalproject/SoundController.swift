//
//  SoundController.swift
//  finalproject
//
//  Created by 陶健坤 on 16/3/12.
//  Copyright © 2016年 jiankun. All rights reserved.
//

import AVFoundation


// Play Sound
class SoundController {

    var musicPlayer = AVAudioPlayer()
    
    func playSoundEffect(filename: String,playtime: Int) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            musicPlayer.numberOfLoops = playtime
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func stopSoundEffect(){
        musicPlayer.stop()
    }
    
    
    
}
