//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Ali serkan Boyracı  on 21.11.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false // only is it false, you can drag the bird
    
    var originalPosition : CGPoint?
    
    enum ColliderType : UInt32 {
        case Bird = 1
        case Box = 2
        //case Ground = 4 when you multiply all of them , it mustn't be equeled the last one. 1+2 !=4 || 1+2+4 != 8
        //case Tree = 8,16,32,64,128...
    }
    

    
    override func didMove(to view: SKView) {
        
        /* Only showing, how to use Spritnode in codes.
        let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: -self.frame.width / 5, y: -self.frame.height / 4)
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)
        */
        
        // PHYSICSBODY
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // not to disappear from frame. to give borders.
        self.scene?.scaleMode = .aspectFit // background will be aspectfit style to scene.
        self.physicsWorld.contactDelegate = self // to collide and contact eachother
        
        
        
        // BIRD
        
        bird = childNode(withName: "bird") as! SKSpriteNode // if you define first in GameScene, you have to define like this
        
        let birdTexture = SKTexture(imageNamed: "bird") // to use frame size and height
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 10.5) // to define bird body
        
        bird.physicsBody?.affectedByGravity = false // wait to tap
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
        
        // for collision
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        // BOXES
        
        
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 4.8, height: boxTexture.size().height / 4.8)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.mass = 0.1
        box1.physicsBody?.allowsRotation = true
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue //to crash eachother
        
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.mass = 0.1
        box2.physicsBody?.allowsRotation = true
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue //to crash eachother
        
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.mass = 0.1
        box3.physicsBody?.allowsRotation = true
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue //to crash eachother
        
       
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.mass = 0.1
        box4.physicsBody?.allowsRotation = true
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue //to crash eachother
        
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.mass = 0.1
        box5.physicsBody?.allowsRotation = true
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue //to crash eachother
        
        
        
        
        
        

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.contactTestBitMask == ColliderType.Bird.rawValue { // to recognize collision
            print("contact")
            
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
 
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100)) // to give impulse
        bird.physicsBody?.affectedByGravity = true // after tapping affected from gravity
         */
        
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
            
        }

    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // we have to use this func to drag the bird.
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false { // it is SKNode Array
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode { // we cast as SKSpriteNode and if we catch the bird, we can chagne bird location
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
            
        }
      
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // when touching bird ended, bird must fly.
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false { // it is SKNode Array
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode { // we cast as SKSpriteNode and if we catch the bird, we can chagne bird location
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition!.x) // to give direction, we have to give minus
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                                
                                
                                
                            }
                        }
                    }
                }
            }
            
        }
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) { // to control all position.
        // Called before each frame is rendered
        
        if let birdPhysicsBody = bird.physicsBody { // to get out from optinal
            if birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.velocity.dx <= 0.1
                && birdPhysicsBody.angularVelocity <= 0 && gameStarted == true { //to checkout bird flying stop.
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.position = originalPosition!
                gameStarted = false
                
            }
        }
        
    }
}
