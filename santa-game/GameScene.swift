//
//  GameScene.swift
//  santa-game
//
//  Created by Sena Uzun on 25.10.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var santa = SKSpriteNode()
    var gift1 = SKSpriteNode()
    var gift2 = SKSpriteNode()
    var gift3 = SKSpriteNode()
    var gift4 = SKSpriteNode()
    var gift5 = SKSpriteNode()


    var gameStarted = false
    var originalPosition : CGPoint?
    
    enum ColliderType : UInt32 {
        case Santa = 1
        case Gift = 3
    }
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        //Physics Body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        
        //Santa
        
        santa = childNode(withName: "santa") as! SKSpriteNode
        
        let santaTexture = SKTexture(imageNamed: "santa")
        
        santa.physicsBody = SKPhysicsBody(circleOfRadius:santaTexture.size().height / 10)
        santa.physicsBody?.affectedByGravity = false
        santa.physicsBody?.isDynamic = true
        santa.physicsBody?.mass = 0.25
        originalPosition = santa.position
        
        santa.physicsBody?.contactTestBitMask = ColliderType.Santa.rawValue
        santa.physicsBody?.categoryBitMask = ColliderType.Santa.rawValue
        santa.physicsBody?.collisionBitMask = ColliderType.Santa.rawValue

        
        //Gift
        let giftTexture = SKTexture(imageNamed: "gift")
        let size = CGSize(width: giftTexture.size().width / 6
                          , height: giftTexture.size().height / 6)
        
        gift1 = childNode(withName: "gift1") as! SKSpriteNode
        gift1.physicsBody = SKPhysicsBody(rectangleOf: size)
        gift1.physicsBody?.isDynamic = true
        gift1.physicsBody?.affectedByGravity = true
        gift1.physicsBody?.allowsRotation = true
        gift1.physicsBody?.mass = 0.15
        
        gift1.physicsBody?.collisionBitMask = ColliderType.Santa.rawValue
        
        gift2 = childNode(withName: "gift2") as! SKSpriteNode
        gift2.physicsBody = SKPhysicsBody(rectangleOf: size)
        gift2.physicsBody?.isDynamic = true
        gift2.physicsBody?.affectedByGravity = true
        gift2.physicsBody?.allowsRotation = true
        gift2.physicsBody?.mass = 0.18
        
        gift2.physicsBody?.collisionBitMask = ColliderType.Santa.rawValue
        
        gift3 = childNode(withName: "gift3") as! SKSpriteNode
        gift3.physicsBody = SKPhysicsBody(rectangleOf: size)
        gift3.physicsBody?.isDynamic = true
        gift3.physicsBody?.affectedByGravity = true
        gift3.physicsBody?.allowsRotation = true
        gift3.physicsBody?.mass = 0.18
        
        gift3.physicsBody?.collisionBitMask = ColliderType.Santa.rawValue
        
        gift4 = childNode(withName: "gift4") as! SKSpriteNode
        gift4.physicsBody = SKPhysicsBody(rectangleOf: size)
        gift4.physicsBody?.isDynamic = true
        gift4.physicsBody?.affectedByGravity = true
        gift4.physicsBody?.allowsRotation = true
        gift4.physicsBody?.mass = 0.18
        
        gift4.physicsBody?.collisionBitMask = ColliderType.Santa.rawValue
        
        gift5 = childNode(withName: "gift5") as! SKSpriteNode
        gift5.physicsBody = SKPhysicsBody(rectangleOf: size)
        gift5.physicsBody?.isDynamic = true
        gift5.physicsBody?.affectedByGravity = true
        gift5.physicsBody?.allowsRotation = true
        gift5.physicsBody?.mass = 0.18
        
        gift5.physicsBody?.collisionBitMask = ColliderType.Santa.rawValue
        
        //Label
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        self.addChild(scoreLabel)

    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Santa.rawValue
            ||  contact.bodyB.collisionBitMask == ColliderType.Santa.rawValue {
            
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == santa {
                                santa.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == santa {
                                santa.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == santa {
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                santa.physicsBody?.applyImpulse(impulse)
                                santa.physicsBody?.affectedByGravity=true
                                
                                gameStarted=true
                            }
                        }
                    }
                }
            }
        }

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if let santaPhysicsBody = santa.physicsBody {
            if santaPhysicsBody.velocity.dx <= 0.1 && santaPhysicsBody.velocity.dy <= 0.1 && santaPhysicsBody.angularVelocity <= 0.1 && gameStarted == true{
                
                santa.physicsBody?.affectedByGravity = false
                santa.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                santa.physicsBody?.angularVelocity = 0
                santa.zPosition = 1
                santa.position = originalPosition!
                
                score += 1
                scoreLabel.text = String(score)
                gameStarted = false

            }
        }
    }

    }

