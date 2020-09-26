//
//  AudioPlayer.swift
//  gheb4750_A05
//
//  Created by Delina Ghebrekristos on 2020-03-22.
//  Copyright © 2020 Delina Ghebrekristos. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

let kSoundState = "kSoundState"
let kBackgroundMusicName = "BackgroundMusic"
let kBackgroundMusicExtension = "caf"

//keeps track of background music and sounds throughout app
class  AudioPlayer {
    
    private init(){}
    static let shared = AudioPlayer()
    
    
    lazy var backgroundMusic : AVAudioPlayer? = {
        guard  let url = Bundle.main.url(forResource: kBackgroundMusicName, withExtension: kBackgroundMusicExtension) else {
            return nil
        }
        do{
            let backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer.numberOfLoops = -1
            return backgroundMusicPlayer
        }catch{
            print("Could not create audio player")
            return nil
        }
    }()
    
    
    func setSounds(_ state: Bool){
        UserDefaults.standard.set(state, forKey: kSoundState)
        UserDefaults.standard.synchronize()
    }
    func getSounds() -> Bool{
        return UserDefaults.standard.bool(forKey: kSoundState)
    }
    
    func playOrStopBackgroundMusic(){
        if AudioPlayer.shared.getSounds(){
            backgroundMusic?.play()
        }else{
            backgroundMusic?.stop()
        }
        
    }
}
