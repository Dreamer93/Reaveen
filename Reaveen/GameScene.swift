//
//  GameScene.swift
//  Reaveen
//
//  Created by student on 02/02/16.
//  Copyright (c) 2016 Matic Teršek. All rights reserved.
//

import SpriteKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
}
class GameScene: SKScene, SKPhysicsContactDelegate {
    //var camera: SKCameraNode?
    var proj = false
    var playerSprite: SKSpriteNode?
    var player: Player?
    var pHealthBar: SKSpriteNode?
    var playerHealthBar: CustomProgressBar?
    var opponent: SKSpriteNode?
    var opp: Opponent?
    var opponentHealthBar: SKSpriteNode?
    var oppHealthBar: CustomProgressBar?
    
    var comboBarBackground: SKSpriteNode?
    var comboProgressBar: SKSpriteNode?
    var progressBar: CustomProgressBar?
    var comboBar: ComboBar?
    
    var button1LocationPassive: SKSpriteNode?
    var button1LocationActive: SKSpriteNode?
    var button2LocationPassive: SKSpriteNode?
    var button2LocationActive: SKSpriteNode?
    var button3LocationPassive: SKSpriteNode?
    var button3LocationActive: SKSpriteNode?
    
    var button1: SKButton?
    var button2: SKButton?
    var button3: SKButton?
    static var level: Int?
    var comboActive = false
    var playerHealth = 3.0

    override func didMove(to view: SKView) {
        /* Setup your scene here */
        let backButton: UIButton = UIButton(defaultButtonImage: "buttonTextureDefault", activeButtonImage: "buttonTextureActive", buttonAction: goToMainMenu)
        backButton.position = CGPoint(x: 7*self.frame.width / 8, y: self.frame.height / 4)
        addChild(backButton)
        
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "maxLevel")
        {
            GameScene.level = Int(name)
        }else{
            GameScene.level = 1
        }
        print(GameScene.level)

        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self

        playerSprite = (self.childNode(withName: "player") as? SKSpriteNode)!
        //playerSprite?.removeFromParent()
        pHealthBar = self.childNode(withName: "playerHealthBar") as? SKSpriteNode
        //pHealthBar?.removeFromParent()
        /*
        playerHealthBar = CustomProgressBar(pHealthBar)
        playerHealthBar!.position = (pHealthBar?.position)!
        playerHealthBar?.name = "healthBar"
        playerHealthBar?.setProgress(1.0)
        playerHealthBar?.zPosition = 1.0
        player = Player(sprite: playerSprite!, bar:playerHealthBar!)
        player!.position = player!.position
        player!.physicsBody = SKPhysicsBody(rectangleOfSize: playerSprite!.size) // 1
        player!.physicsBody?.dynamic = true // 2
        player!.physicsBody?.categoryBitMask = PhysicsCategory.Monster // 3
        player!.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile // 4
        player!.physicsBody?.collisionBitMask = PhysicsCategory.None
        player!.physicsBody?.usesPreciseCollisionDetection = true
        player?.health = 2.0 // * Double(count)
        player?.maxHealth = 2.0
        addChild(player!)
        */
        
        opponentHealthBar = self.childNode(withName: "opponentHealthBar") as? SKSpriteNode
        opponentHealthBar?.removeFromParent()   
        oppHealthBar = CustomProgressBar(opponentHealthBar)
        oppHealthBar!.position = (opponentHealthBar?.position)!
        oppHealthBar?.name = "healthBar"
        oppHealthBar?.setProgress(1.0)
        oppHealthBar?.zPosition = 1.0
        opponent = self.childNode(withName: "opponent") as? SKSpriteNode
        opponent!.removeFromParent()
        opp = Opponent(sprite: opponent!, bar: oppHealthBar!)
        opp!.position = opponent!.position
        opp!.physicsBody = SKPhysicsBody(rectangleOf: opponent!.size) // 1
        opp!.physicsBody?.isDynamic = true // 2
        opp!.physicsBody?.categoryBitMask = PhysicsCategory.Monster // 3
        opp!.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile // 4
        opp!.physicsBody?.collisionBitMask = PhysicsCategory.None
        opp!.physicsBody?.usesPreciseCollisionDetection = true
        opp?.health = 2.0 //* Double(count)
        opp?.maxHealth = 2.0
        addChild(opp!)
        
        comboBarBackground = self.childNode(withName: "comboBarBackground") as? SKSpriteNode
        comboBarBackground?.isHidden = true
        comboProgressBar = self.childNode(withName: "comboProgressBar") as? SKSpriteNode
        comboProgressBar?.removeFromParent()


        button1LocationActive = self.childNode(withName: "button1LocationActive") as? SKSpriteNode
        button1LocationActive?.removeFromParent()
        button1LocationPassive = self.childNode(withName: "button1LocationPassive") as? SKSpriteNode
        button1LocationPassive?.removeFromParent()
        
        button1 = SKButton(defaultButtonImage: (button1LocationPassive)!, activeButtonImage: (button1LocationActive)!, buttonAction: ComboStartSkill, parameter: .comboStartSkill)
        addChild(button1!)
        
        button2LocationActive = self.childNode(withName: "button2LocationActive") as? SKSpriteNode
        button2LocationActive?.removeFromParent()
        button2LocationPassive = self.childNode(withName: "button2LocationPassive") as? SKSpriteNode
        button2LocationPassive?.removeFromParent()
        button2 = SKButton(defaultButtonImage: (button2LocationPassive)!, activeButtonImage: (button2LocationActive)!, buttonAction: ComboStartSkill, parameter: .dashSkill)
        addChild(button2!)

        button3LocationActive = self.childNode(withName: "button3LocationActive") as? SKSpriteNode
        button3LocationActive?.removeFromParent()
        button3LocationPassive = self.childNode(withName: "button3LocationPassive") as? SKSpriteNode
        button3LocationPassive?.removeFromParent()
        
        if(GameScene.level >= 2){

            button3 = SKButton(defaultButtonImage: (button3LocationPassive)!, activeButtonImage: (button3LocationActive)!, buttonAction: ComboStartSkill, parameter: .projectileSkill)
            addChild(button3!)
        }
        
        
        let bar = SKSpriteNode(imageNamed: "filledBar.jpg")
        bar.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        bar.size = (comboProgressBar?.size)!
        bar.yScale = 2.0
        let surround = self.childNode(withName: "comboSurround")
        surround?.isHidden = true
        progressBar = CustomProgressBar(bar)
        progressBar!.position = (comboProgressBar?.position)!
        progressBar?.name = "progressBar"
        progressBar?.setProgress(0.0)
        progressBar?.zPosition = 1.0
        comboBar = ComboBar(backgroundNode: comboBarBackground!, sur: surround!, maskedBar: progressBar!, lowThrashValue: 1.0, highThrashValue: 2.0)
        addChild(comboBar!)
        attackAI(Double(GameScene.level!))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        
    }
    func goToMainMenu () {
        let endScene = MainMenuScene(fileNamed: "MainMenuScene")! //Replace here with the target scene
        endScene.scaleMode = .aspectFill
        self.view?.presentScene(endScene, transition: SKTransition.push(with: .down, duration: 0.35)) // Performs the transition of scene if the button was touch
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(comboBar?.progressBar.maskNode?.xScale > 2.0){
            comboBar?.background.isHidden = true
            comboBar?.surround.isHidden = true
            comboBar!.progressBar.setProgress(0.0)
            self.comboBar!.removeAction(forKey: "Combo")
        }
        if(opp?.healthBar.maskNode?.xScale >= CGFloat((opp?.getHealthRatio())!)){
            self.opp!.removeAction(forKey: "HealthProgress")
        }
        pHealthBar?.position.x = (playerSprite?.position.x)!
    }
    
    func updateCamera(){
        let forwardPlayer = SKAction.move(to: CGPoint(x:(camera?.position.x)!+6.0 , y: (camera?.position.y)!), duration: TimeInterval(0.04))
        
        let backPlayer = SKAction.move(to: CGPoint(x: (camera?.position.x)!, y: (camera?.position.y)!), duration: TimeInterval(0.04))
        
        self.camera!.run(SKAction.sequence([forwardPlayer, backPlayer]))
        
    }
    
    func attackAI(_ level: Double){
        let tmp = 3.0/(level * 0.5)
        let action = SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: tmp),
            SKAction.run({self.DashSkillOpponent(tmp)})]) )
        self.run(action, withKey: "Opponent")

    }
}
