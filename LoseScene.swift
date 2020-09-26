//
//  LoseScene.swift
//  
//
//  Created by Delina Ghebrekristos on 2020-03-21.
//

import SpriteKit
import GameplayKit
import Foundation

class LoseScene: SKScene {
    
    
    var youLose : SKSpriteNode!

    
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
        
        youLose = SKSpriteNode(imageNamed: "You_Lose")
        
        youLose.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        
        youLose.position = CGPoint(x: frame.midX, y: frame.midY+youLose.size.height*2)
        addChild(youLose)
        
    }
   
}
