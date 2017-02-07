//
//  SettingsMenuScene.swift
//  Reaveen
//
//  Created by Matic Vrenko on 03/02/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//


import UIKit
import SpriteKit

class SettingsMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Settings"
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height*0.3)
        addChild(label)
        
        let backButton: UIButton = UIButton(defaultButtonImage: "buttonTextureDefault", activeButtonImage: "buttonTextureActive", buttonAction: goToMainMenu)
        backButton.position = CGPoint(x: 7*self.frame.width / 8, y: self.frame.height / 1.5)
        addChild(backButton)
        /*
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if(defaults.boolForKey("Sound")){
            let checkbox = childNodeWithName("soundCheckbox") as! SKSpriteNode
            checkbox.texture = SKTexture(imageNamed: "checkboxChecked")
        }else{
            let checkbox = childNodeWithName("soundCheckbox") as! SKSpriteNode
            checkbox.texture = SKTexture(imageNamed: "checkboxUnchecked")
        }*/
        
        
        
    }
    
    func goToMainMenu () {
        let endScene = MainMenuScene(fileNamed: "MainMenuScene")! //Replace here with the target scene
        endScene.scaleMode = .aspectFill
        self.view?.presentScene(endScene, transition: SKTransition.push(with: .down, duration: 0.35)) // Performs the transition of scene if the button was touch
    }
    /*
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches{
            let positionInScene = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "soundCheckbox"
                {
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setBool(!defaults.boolForKey("Sound"), forKey: "Sound")
                    if(defaults.boolForKey("Sound")){
                        let checkbox = childNodeWithName("soundCheckbox") as! SKSpriteNode
                        checkbox.texture = SKTexture(imageNamed: "checkboxChecked")
                    }else{
                        let checkbox = childNodeWithName("soundCheckbox") as! SKSpriteNode
                        checkbox.texture = SKTexture(imageNamed: "checkboxUnchecked")
                    }
                }
            }
        }
        
        
    }*/
    
    
    
}
