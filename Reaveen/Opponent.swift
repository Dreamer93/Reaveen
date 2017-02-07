//
//  Opponent.swift
//  reaveen
//
//  Created by student on 03/02/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

import Foundation
import SpriteKit

class Opponent: SKSpriteNode{
    var healthBar: CustomProgressBar
    init(sprite: SKSpriteNode, bar: CustomProgressBar) {
        healthBar = bar
        super.init(texture: sprite.texture, color: sprite.color, size: sprite.size)
        self.addChild(healthBar)

    }
    
    required init?(coder aDecoder: NSCoder) {
        // Class does not want to be NSCoding-compatible
        fatalError("init(coder:) has not been implemented")
    }
    var maxHealth = 0.0
    var health = 0.0
    var strength = 0.0
    var dexterity = 0.0
    var inteligence = 0.0
    var skillSet = ["test"]

    func updateHealthBar(){
        healthBar.setProgress(CGFloat(getHealthRatio()))
        
        let hp = SKAction.repeatForever(
            SKAction.sequence([SKAction.wait(forDuration: 0.01),
                SKAction.run({self.updateProgress(0.1)})
                ]))
        self.run(hp, withKey: "HealthProgress")
        
                
    }
    func updateProgress(_ count: Double) {
        let sum = CGFloat(0.05 * count) + (healthBar.maskNode!.xScale)
        healthBar.setProgress(sum)
        print(healthBar.maskNode?.xScale)
        
    }
    func getHealthRatio() -> Double{
        let sum = health/maxHealth
        return sum
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
