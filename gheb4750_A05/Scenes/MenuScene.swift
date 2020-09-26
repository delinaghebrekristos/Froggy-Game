//
//  GameScene.swift
//  gheb4750_A05
//
//  Created by Delina Ghebrekristos on 2020-03-20.
//  Copyright © 2020 Delina Ghebrekristos. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation
import AVFoundation

class MenuScene: SKScene {
    
    
    var frog : SKSpriteNode!
    var playButton : SKSpriteNode!
    var playMButton : SKSpriteNode!
    var stopMButton : SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        layoutScene()
    }
    
    func layoutScene(){
        backgroundColor = SKColor.white
        
        frog = SKSpriteNode(imageNamed: "Frog")
        playButton = SKSpriteNode(imageNamed: "Play")
        playButton.name = "Play_Game"
        playMButton = SKSpriteNode(imageNamed: "Play_Sound")
        playMButton.name = "Play_Music"
        
        stopMButton = SKSpriteNode(imageNamed: "Stop_Sound")
        stopMButton.name = "Stop_Music"
        
        frog.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        frog.position = CGPoint(x: frame.midX, y: frame.midY+frog.size.height*2)
        addChild(frog)
        
        playButton.position = CGPoint(x: frame.midX, y: frame.midY+110)
        addChild(playButton)
  
        playMButton.position = CGPoint(x: frame.midX, y: frame.midY+50)
        addChild(playMButton)
    
        stopMButton.position = CGPoint(x: frame.midX, y: frame.midY+10)
        
        addChild(stopMButton)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "Play_Music"{
                AudioPlayer.shared.setSounds(true)
                AudioPlayer.shared.playOrStopBackgroundMusic()
                //Use this for game!!
                //print("The \(playButton!.name!) is touched ")
                //AudioPlayer.shared.setSounds(true)
                //run("BackgroundMusic.mp3", onNode: self)
                
            }
            if touchedNode.name == "Stop_Music"{
                AudioPlayer.shared.setSounds(false)
                AudioPlayer.shared.playOrStopBackgroundMusic()
                //Use this for game!!
                //print("The \(playButton!.name!) is touched ")
                //AudioPlayer.shared.setSounds(true)
                //run("BackgroundMusic.mp3", onNode: self)
                
            }
            if touchedNode.name == "Play_Game"{
                print("The \(playButton!.name!) is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 2)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
    func run(_ fileName: String, onNode: SKNode){
        if AudioPlayer.shared.getSounds(){
            onNode.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
        }
        
    }
}
