//
//  Projectile.swift
//  ReaveenDestiny
//
//  Created by Matic Vrenko on 25/01/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

import Foundation
import SpriteKit

class Projectile: SKSpriteNode{
    
    init() {
        let spriteColor = SKColor.red
        let texture = SKTexture(imageNamed: "slice12_12")
        let spriteSize = CGSize(width: texture.size().width, height: texture.size().height)
        
        super.init(texture: texture, color: spriteColor, size: spriteSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Class does not want to be NSCoding-compatible
        fatalError("init(coder:) has not been implemented")
    }
    
    var damage = 0.0
    
}
