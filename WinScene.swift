//
//  WinScene.swift
//  
//
//  Created by Delina Ghebrekristos on 2020-03-21.
//

import SpriteKit
import GameplayKit
import Foundation

class WinScene: SKScene {
    
    
    var youWin : SKSpriteNode!
    var goBack : SKSpriteNode!

    
    override func didMove(to view: SKView) {
        layoutScene()
        
        run(SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.run {
            let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 2)
            let menuScene = MenuScene(size: self.size)
            self.view?.presentScene(menuScene, transition: transition)
        }]))
        
    }
    
    func layoutScene(){
        backgroundColor = SKColor.white
        
        youWin = SKSpriteNode(imageNamed: "You_Win")
        goBack = SKSpriteNode(imageNamed: "Go_Back")
        
        youWin.size = CGSize(width: frame.size.width/2, height: frame.size.width/5)
        youWin.position = CGPoint(x: frame.midX, y: frame.midY+youWin.size.height*2)
        
        goBack.size = CGSize(width: frame.size.width/1.3, height: frame.size.width/8)
        goBack.position = CGPoint(x: frame.midX, y: frame.midY+goBack.size.height)
        
        addChild(youWin)
        addChild(goBack)
        
        
    }
   
}
