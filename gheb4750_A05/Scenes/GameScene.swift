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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var frog : SKSpriteNode!
    var frogX: CGFloat!      //x position
    var frogY: CGFloat!     //y position
    
    var deadFrog: SKSpriteNode!
    
    var yellowCar1 : SKSpriteNode!
    var yellowCar2 : SKSpriteNode!
   // var actionMove: SKAction!
    var redCar1 : SKSpriteNode!
    var redCar2 : SKSpriteNode!
    var log1: SKSpriteNode!
    var bottomY: CGFloat!
    var log2: SKSpriteNode!
    var topY: CGFloat!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var upButton: SKSpriteNode!
    var downButton: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        
        layoutScene()
        createYellowCars()
        createRedCars()
    }
    
    //sets up the screen layout
    func layoutScene(){
        backgroundColor = SKColor.white
        
        leftButton = SKSpriteNode(imageNamed: "Left_Button")
        leftButton.name = "Left_Button"
        rightButton = SKSpriteNode(imageNamed: "Right_Button")
        rightButton.name = "Right_Button"
        upButton = SKSpriteNode(imageNamed: "Up_Button")
        upButton.name = "Up_Button"
        downButton = SKSpriteNode(imageNamed: "Down_Button")
        downButton.name = "Down_Button"
        frog = SKSpriteNode(imageNamed: "Frog")
        
        redCar1 = SKSpriteNode(imageNamed: "Red_Car")
        redCar2 = SKSpriteNode(imageNamed: "Red_Car")
        log1 = SKSpriteNode(imageNamed: "Log")
        log2 = SKSpriteNode(imageNamed: "Log")
        
        frog.size = CGSize(width: frame.size.width/8, height: frame.size.width/8)
        
        leftButton.size = CGSize(width: frame.size.width/4 , height: frame.size.width/7)
        rightButton.size = CGSize(width: frame.size.width/4 , height: frame.size.width/7)
        upButton.size = CGSize(width: frame.size.width/5 , height: frame.size.width/7)
        downButton.size = CGSize(width: frame.size.width/5 , height: frame.size.width/7)

        log1.zPosition = 1
        log2.zPosition = 1
        upButton.zPosition = 1
        downButton.zPosition=1
        
        leftButton.position = CGPoint(x: frame.minX+(frame.midX/3), y: frame.size.width/7)
        rightButton.position = CGPoint(x: frame.maxX-(frame.midX/3), y: frame.size.width/7)
        upButton.position = CGPoint(x: frame.midX-(frame.midX/4), y: frame.size.width/7)
        downButton.position = CGPoint(x: frame.midX+(frame.midX/4), y: frame.size.width/7)
        

        addChild(leftButton)
        addChild(rightButton)
        addChild(upButton)
        addChild(downButton)
        
        
        log1.size = CGSize(width: frame.width, height: frame.size.width/7)
        log2.size = CGSize(width: frame.width, height: frame.size.width/7)
        topY = frame.minY+log2.size.height*7
        log1.position = CGPoint(x: frame.midX, y: topY)
        log2.position = CGPoint(x:frame.midX, y: frame.minY + log2.size.height*2)
        topY = topY + log2.size.height
        bottomY = frame.size.width/7 + log2.size.height
        
        
        addChild(log1)
        addChild(log2)
        
        frog.zPosition = 2
        frogX = frame.midX
        frogY = frame.minY+log1.size.height*2
        frog.position = CGPoint(x: frogX, y: frogY)
        frog.physicsBody = SKPhysicsBody(rectangleOf: frog.size)
        frog.physicsBody?.isDynamic = true
        frog.physicsBody?.categoryBitMask = PhysicsCategories.frog
        frog.physicsBody?.contactTestBitMask = PhysicsCategories.ycar1 | PhysicsCategories.ycar2 | PhysicsCategories.rcar1 | PhysicsCategories.rcar2
        frog.physicsBody?.collisionBitMask = PhysicsCategories.ycar1 | PhysicsCategories.ycar2 | PhysicsCategories.rcar1 | PhysicsCategories.rcar2
        frog.physicsBody?.affectedByGravity = false
        frog.physicsBody?.usesPreciseCollisionDetection = true
        //frog.physicsBody?.usesPreciseCollisionDetection = true
        addChild(frog)
        
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        
       /** let endLocation = CGPoint(x: -self.frame.width, y: frame.minY + log2.size.height*3)
        //let realDest = realDestination(yellowCar1.position, endPoint: endLocation)
        actionMove = SKAction.repeatForever(SKAction.move(to: endLocation, duration: 5))
               
        yellowCar1.run(actionMove)**/
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            run(SKAction.playSoundFileNamed("frog_hop.caf", waitForCompletion: false)) // sound does not play! sounds only play if we do not present a new scene!
            if touchedNode.name == "Up_Button"{
                frogY = frogY + log1.size.height
                if frogY < topY{
                    frog.position = CGPoint(x: frogX, y: frogY )
                    print("where the frog is at \(frogY!), where the log is at \(topY-log2.size.height) ")
                    if frogY == (topY-log2.size.height){
                        frogDidCollideWithLog()
                    }
                }
                else{
                    frogY = frogY - log1.size.height
                }
            }
            if touchedNode.name == "Down_Button"{
                frogY = frogY - log1.size.height
                if frogY > bottomY{
                    frog.position = CGPoint(x: frogX, y: frogY )
                }else{
                     frogY = frogY + log1.size.height
                }
                
            }
            if touchedNode.name == "Left_Button"{
                frogX = frogX - frog.size.width
                if frogX != frame.minX{
                    frog.position = CGPoint(x: frogX, y: frogY )
                }
                else{
                    frogX = frogX + frog.size.width
                }
            }
            if touchedNode.name == "Right_Button"{
                frogX = frogX + frog.size.width
                if frogX != frame.maxX{
                    frog.position = CGPoint(x: frogX, y: frogY )
                }
                else{
                    frogX = frogX - frog.size.width
                }
            }
        }
    }
    
    func createYellowCars(){
        run(SKAction.playSoundFileNamed("carhorn.caf", waitForCompletion: true)) // sound does not play! sounds only play if we do not present a new scene!
        for i in 0...6{
            yellowCar1 = SKSpriteNode(imageNamed: "Yellow_Car")
            yellowCar1.name = "Yellow_Car1"
            yellowCar1.size = CGSize(width: frame.size.width/7, height: frame.size.width/7)
            yellowCar1.position = CGPoint(x: frame.maxX-(CGFloat(i)), y: frame.minY + log2.size.height*3)
            yellowCar1.zPosition = 2
            yellowCar1.physicsBody = SKPhysicsBody(rectangleOf: yellowCar1.size)
            yellowCar1.physicsBody?.isDynamic = true
            yellowCar1.physicsBody?.categoryBitMask = PhysicsCategories.ycar1
            yellowCar1.physicsBody?.contactTestBitMask = PhysicsCategories.frog
            yellowCar1.physicsBody?.affectedByGravity = false
            yellowCar1.physicsBody?.collisionBitMask = PhysicsCategories.none
            yellowCar1.physicsBody?.usesPreciseCollisionDetection = true
            self.addChild(yellowCar1)
        }
        
        for i in 0...6{
            yellowCar2 = SKSpriteNode(imageNamed: "Yellow_Car")
            yellowCar2.name = "Yellow_Car2"
            yellowCar2.size = CGSize(width: frame.size.width/7, height: frame.size.width/7)
            yellowCar2.position = CGPoint(x: frame.maxX-(CGFloat(i)), y: frame.minY+log2.size.height*5)
            yellowCar2.zPosition = 2
            yellowCar2.physicsBody = SKPhysicsBody(rectangleOf: yellowCar2.size)
            yellowCar2.physicsBody?.isDynamic = true
            yellowCar2.physicsBody?.categoryBitMask = PhysicsCategories.ycar2
            yellowCar2.physicsBody?.contactTestBitMask = PhysicsCategories.frog
            yellowCar2.physicsBody?.affectedByGravity = false
            yellowCar2.physicsBody?.collisionBitMask = PhysicsCategories.none
            yellowCar2.physicsBody?.usesPreciseCollisionDetection = true
  
            self.addChild(yellowCar2)
        }
    }
    
    func createRedCars(){
        for i in 0...4{
            redCar1 = SKSpriteNode(imageNamed: "Red_Car")
            redCar1.name = "Red_Car1"
            redCar1.size = CGSize(width: frame.size.width/7, height: frame.size.width/7)
            redCar1.position = CGPoint(x: frame.minX+(CGFloat(i)), y: frame.minY + log2.size.height*4)
            redCar1.zPosition = 2
            redCar1.physicsBody = SKPhysicsBody(rectangleOf: redCar1.size)
            redCar1.physicsBody?.isDynamic = true
            redCar1.physicsBody?.categoryBitMask = PhysicsCategories.rcar1
            redCar1.physicsBody?.contactTestBitMask = PhysicsCategories.frog
            redCar1.physicsBody?.affectedByGravity = false
            redCar1.physicsBody?.collisionBitMask = PhysicsCategories.none
            redCar1.physicsBody?.usesPreciseCollisionDetection = true
            self.addChild(redCar1)
        }
        
        for i in 0...7{
            redCar2 = SKSpriteNode(imageNamed: "Red_Car")
            
            redCar2.name = "Red_Car2"
            redCar2.size = CGSize(width: frame.size.width/7, height: frame.size.width/7)
            redCar2.zPosition = 2
            redCar2.position = CGPoint(x: frame.minX+(CGFloat(i)), y: frame.minY+log2.size.height*6)
            redCar2.physicsBody = SKPhysicsBody(rectangleOf: redCar1.size)
            redCar2.physicsBody?.isDynamic = true
            redCar2.physicsBody?.categoryBitMask = PhysicsCategories.rcar2
            redCar2.physicsBody?.contactTestBitMask = PhysicsCategories.frog
            redCar2.physicsBody?.affectedByGravity = false
            redCar2.physicsBody?.collisionBitMask = PhysicsCategories.none
            redCar2.physicsBody?.usesPreciseCollisionDetection = true
            self.addChild(redCar2)
        }
    }
    
    func createDeadFrog(frog_x: CGFloat, frog_y: CGFloat){
        deadFrog = SKSpriteNode(imageNamed: "Dead_Frog")
        deadFrog.name = "dead_Frog"
        deadFrog.size = CGSize(width: frame.size.width/8, height: frame.size.width/8)
        deadFrog.position = CGPoint(x: frog_x, y: frog_y)
        deadFrog.zPosition = 2
        self.addChild(deadFrog)
    }
    
    func movingRedCars(){
        self.enumerateChildNodes(withName: "Red_Car2", using: ({
            (node, Error) in
            node.position.x += 1
            
            if node.position.x > (self.frame.size.width) {
                self.run(SKAction.playSoundFileNamed("carhorn.caf", waitForCompletion: true)) // sound does not play! sounds only play if we do not present a new scene!
                node.position.x -= self.frame.size.width*2
                
            }
        }))
        
        self.enumerateChildNodes(withName: "Red_Car1", using: ({
            (node, Error) in
            node.position.x += 2
            
            if node.position.x > (self.frame.size.width) {
                self.run(SKAction.playSoundFileNamed("carhorn.caf", waitForCompletion: true)) // sound does not play! sounds only play if we do not present a new scene!

                node.position.x -= self.frame.size.width*2
                
            }
        }))
        
    }
    
    func movingYellowCars(){
        self.enumerateChildNodes(withName: "Yellow_Car2", using: ({
            (node, Error) in
            node.position.x -= 4

            if node.position.x < -(self.frame.size.width) {
                self.run(SKAction.playSoundFileNamed("carhorn.caf", waitForCompletion: true)) // sound does not play! sounds only play if we do not present a new scene!

                node.position.x += self.frame.size.width*2
                
            }
        }))
        
        
        self.enumerateChildNodes(withName: "Yellow_Car1", using: ({
            (node, Error) in
            node.position.x -= 3
            
            if node.position.x < -(self.frame.size.width) {
                self.run(SKAction.playSoundFileNamed("carhorn.caf", waitForCompletion: true)) // sound does not play! sounds only play if we do not present a new scene!

                node.position.x += self.frame.size.width*2
                
            }
        }))
        
    }
    
    override func update(_ currentTime: TimeInterval){
       movingYellowCars()
       movingRedCars()
    }
    
    func frogDidCollideWithCar(_ frog:SKSpriteNode, _ car:SKSpriteNode) {
        run(SKAction.playSoundFileNamed("crash.caf", waitForCompletion: true)) // sound does not play! sounds only play if we do not present a new scene!
        print("Hit")
        
        createDeadFrog(frog_x: frog.position.x, frog_y: frog.position.y)
        frog.removeFromParent()
        run(SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.run({
            let loseScene = LoseScene(size: self.size)
            let transition = SKTransition.doorway(withDuration: 1.5)
            self.view?.presentScene(loseScene, transition: transition) // we killed the monster, we win!
        })]))
        
    }
    
    func frogDidCollideWithLog() {
        print("Passed!")
        run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run({
            let winScene = WinScene(size: self.size)
            let transition = SKTransition.doorway(withDuration: 1.5)
            self.view?.presentScene(winScene, transition: transition) // we killed the monster, we win!
        })]))
        
    }
    
    
     // we must implement this delegate method
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }


        if (firstBody.categoryBitMask == PhysicsCategories.frog && secondBody.categoryBitMask == PhysicsCategories.ycar1) || (firstBody.categoryBitMask == PhysicsCategories.ycar1 && secondBody.categoryBitMask == PhysicsCategories.frog) {
            print("Collision with 1st yellow car and frog occurred")
            frogDidCollideWithCar(frog, yellowCar1)
            
        } else if (firstBody.categoryBitMask == PhysicsCategories.frog && secondBody.categoryBitMask == PhysicsCategories.ycar2) || (firstBody.categoryBitMask == PhysicsCategories.ycar2 && secondBody.categoryBitMask == PhysicsCategories.frog) {

            print("Collision with 2nd yellow car and frog occurred")
            frogDidCollideWithCar(frog, yellowCar2)
            
        } else if (firstBody.categoryBitMask == PhysicsCategories.frog && secondBody.categoryBitMask == PhysicsCategories.rcar1) || (firstBody.categoryBitMask == PhysicsCategories.rcar1 && secondBody.categoryBitMask == PhysicsCategories.frog) {

            print("Collision with 1st red car and frog occurred")
            frogDidCollideWithCar(frog, redCar1)
            
        }else if (firstBody.categoryBitMask == PhysicsCategories.frog && secondBody.categoryBitMask == PhysicsCategories.rcar2) || (firstBody.categoryBitMask == PhysicsCategories.rcar2 && secondBody.categoryBitMask == PhysicsCategories.frog) {

            print("Collision with 2nd red car and frog occurred")
            frogDidCollideWithCar(frog, redCar2)
            
        }
        
         
     } //didBeginContact
   
}
