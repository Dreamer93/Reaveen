//
//  ComboBar.swift
//  Reaveen
//
//  Created by Matic Vrenko on 02/02/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

import Foundation
import SpriteKit

class ComboBar : SKNode{
    var background: SKSpriteNode
    var surround: SKNode
    var progressBar: CustomProgressBar
    var lowThrash: CGFloat
    var highThrash: CGFloat
    
    init(backgroundNode: SKSpriteNode, sur: SKNode, maskedBar: CustomProgressBar, lowThrashValue: CGFloat, highThrashValue: CGFloat){
        
        background = backgroundNode
        surround = sur
        progressBar = maskedBar
        lowThrash = lowThrashValue
        highThrash = highThrashValue
        super.init()
        self.addChild(progressBar)
    }
    
    /**
     Required so XCode doesn't throw warnings
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func startCombo(){
        self.background.isHidden = false
        self.surround.isHidden = false
        let combo = SKAction.repeatForever(
            SKAction.sequence([SKAction.wait(forDuration: 0.01),
                SKAction.run({self.updateProgress(0.1)})
                ]))
        self.run(combo, withKey: "Combo")
    }
    
    func updateProgress(_ count: Double) {
        let sum = CGFloat(0.05 * count) + (self.progressBar.maskNode!.xScale)
        self.progressBar.setProgress(sum)
        
    }

}
