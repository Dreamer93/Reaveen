//
//  SKButton.swift
//  ReaveenDestiny
//
//  Created by Matic Vrenko on 25/01/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

import Foundation
import SpriteKit

class SKButton: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: (_ skill: SkillType) -> Void
    var actionParam: SkillType
    
    init(defaultButtonImage: SKSpriteNode, activeButtonImage: SKSpriteNode, buttonAction: @escaping (_ skill: SkillType) -> Void, parameter: SkillType) {
        defaultButton = defaultButtonImage
        activeButton = activeButtonImage
        activeButton.isHidden = true
        action = buttonAction
        actionParam = parameter
        super.init()
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    /**
     Required so XCode doesn't throw warnings
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent!) {
        activeButton.isHidden = false
        defaultButton.isHidden = true
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent!) {
        if let touch = touches.first{
            let location: CGPoint = touch.location(in: self)
            
            if defaultButton.contains(location) {
                activeButton.isHidden = false
                defaultButton.isHidden = true
            } else {
                activeButton.isHidden = true
                defaultButton.isHidden = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent!) {
        if let touch = touches.first
        {
            let location: CGPoint = touch.location(in: self)
            
            if defaultButton.contains(location) {
                action(actionParam)
            }
            
            activeButton.isHidden = true
            defaultButton.isHidden = false
        }
    }
}
