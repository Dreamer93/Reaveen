//
//  ProjectileSkill.swift
//  Reaveen
//
//  Created by student on 02/02/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func ProjectileSkill(){
        view!.isUserInteractionEnabled = false
        self.comboBar!.removeAction(forKey: "Combo")
        let projectile = Projectile()
        projectile.position = CGPoint(x: 254, y: 448)
        projectile.xScale = 2.0
        projectile.yScale = 2.0
        projectile.zPosition = 3.0
        addChild(projectile)
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        projectile.damage = 1.0
        
        // 6 - Get the direction of where to shoot
        let offset = self.opponent!.position - projectile.position
        let direction = offset.normalized()
        
        // 7 - Make it shoot far enough to be guaranteed off screen
        let shootAmount = direction * 1000
        
        // 8 - Add the shoot amount to the current position
        let realDest = shootAmount + projectile.position
        
        // 9 - Create the actions
        self.playerSprite?.run(SKAction(named: "ProjectileCharAnimation")!)
        
        projectile.run(SKAction.repeatForever(SKAction(named: "projectile")!))
        projectile.run(SKAction(named: "proj")!)
        
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([SKAction.wait(forDuration: 0.3),actionMove, actionMoveDone]))
       // 254, 448
        // 10 reload the bar
        self.run(SKAction.run({
            self.comboBar!.progressBar.setProgress(0.0)
            }))
        comboBar?.background.isHidden = true
        comboBar?.surround.isHidden = true
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
    
        if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
                projectileDidCollideWithMonster(secondBody.node as! Projectile, monster: firstBody.node as! Opponent)
        }
        
    }
    func projectileDidCollideWithMonster(_ projectile:Projectile, monster:Opponent) {
        projectile.removeFromParent()
        monster.health -= projectile.damage
        isMonsterDead(monster.health, projectile: projectile)
        
    }
}
