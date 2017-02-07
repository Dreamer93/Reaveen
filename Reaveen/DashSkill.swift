//
//  DashSkill.swift
//  Reaveen
//
//  Created by student on 02/02/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

import Foundation
extension GameScene {
    func DashSkill(){
        // Disable touches
        self.comboBar!.removeAction(forKey: "Combo")
        view!.isUserInteractionEnabled = false
        // Determine speed of the palyer
        var actualDuration = 1.0
        
        // Create the actions
        let forwardPlayer = SKAction.move(to: CGPoint(x: (opponent?.position.x)! - (opponent?.size.width)!/1.5, y: (opponent?.position.y)!), duration: TimeInterval(actualDuration))
        
        let backPlayer = SKAction.move(to: CGPoint(x: (playerSprite?.position.x)!, y: (playerSprite?.position.y)!), duration: TimeInterval(actualDuration))
        
        self.playerSprite!.run(SKAction.sequence([forwardPlayer, backPlayer]))
        
        actualDuration *= 0.1
        
        let forwardOpponent = SKAction.move(to: CGPoint(x: (opponent?.position.x)!-10, y: (opponent?.position.y)!), duration: TimeInterval(actualDuration))
        
        let backOpponent = SKAction.move(to: CGPoint(x: (opponent?.position.x)!, y: (opponent?.position.y)!), duration: TimeInterval(actualDuration))
        let rotateOpponent = SKAction.rotate(byAngle: CGFloat(M_PI/(-8.0)), duration: 0.1)
        let rotateOpponentBack = SKAction.rotate(toAngle: CGFloat(0.0), duration: 0.1)
        opp?.health -= 1.1
    
        self.opp!.run(SKAction.sequence(
            [SKAction.wait(forDuration: 0.9),
                SKAction.run({self.updateCamera(); self.opp?.updateHealthBar()}),
                forwardOpponent,
                rotateOpponent,
                backOpponent,
                rotateOpponentBack
            ]))
        self.run(SKAction.sequence([SKAction.wait(forDuration: 2.0),
                    SKAction.run({self.isMonsterDead((self.opp?.health)!, projectile: self.opp!)
            })]))

    }
    
    
    
    
    
    
    
    
    
    func DashSkillOpponent(_ waitTime: Double){
        // Disable touches
        // self.comboBar!.removeActionForKey("Combo")
        //view!.userInteractionEnabled = false
        // Determine speed of the palyer
        let actualDuration = waitTime/3.0
        
        // Create the actions
        let forwardPlayer = SKAction.move(to: CGPoint(x: (playerSprite?.position.x)! + (playerSprite?.size.width)!/1.5, y: (playerSprite?.position.y)!), duration: TimeInterval(actualDuration))
        
        let backPlayer = SKAction.move(to: CGPoint(x: (opponent?.position.x)!, y: (opponent?.position.y)!), duration: TimeInterval(actualDuration))
        
        self.opp!.run(SKAction.sequence([forwardPlayer, backPlayer]))
        
        let actualDuration1 = actualDuration * 0.1
        
        let forwardOpponent = SKAction.move(to: CGPoint(x: (playerSprite?.position.x)!-10, y: (playerSprite?.position.y)!), duration: TimeInterval(actualDuration1))
        
        let backOpponent = SKAction.move(to: CGPoint(x: (playerSprite?.position.x)!, y: (playerSprite?.position.y)!), duration: TimeInterval(actualDuration1))
        let rotateOpponent = SKAction.rotate(byAngle: CGFloat(M_PI/(-8.0)), duration: 0.1)
        let rotateOpponentBack = SKAction.rotate(toAngle: CGFloat(0.0), duration: 0.1)
        playerHealth -= 1.1
        
        self.playerSprite!.run(SKAction.sequence(
            [SKAction.wait(forDuration: actualDuration-0.1),
                SKAction.run({self.updateCamera(); self.opp?.updateHealthBar()}),
                forwardOpponent,
                rotateOpponent,
                backOpponent,
                rotateOpponentBack,
            ]))
        self.run(SKAction.sequence([SKAction.wait(forDuration: 2.0),
            SKAction.run({self.isPlayerDead(self.playerHealth, projectile: self.playerSprite!)
            })]))
        
    }
    
    func isPlayerDead(_ hp:Double,projectile:SKSpriteNode){
        if (hp <= 0.0) {
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                ()
            })
            projectile.removeFromParent()
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
    }
}

    
    
    
    
    
    
    
    
    

