//
//  ComboStartSkill.swift
//  Reaveen
//
//  Created by student on 02/02/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

import Foundation
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
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

extension GameScene{
    func ComboStartSkill(_ skill: SkillType) -> Void{
        if(skill == .comboStartSkill){
            comboActive = true
            comboBar!.startCombo()
            print("Combo started")
            return
        }
        
        if(comboActive && comboBar!.progressBar.maskNode?.xScale > comboBar!.lowThrash && comboBar!.progressBar.maskNode?.xScale < comboBar?.highThrash){
            if(skill == .dashSkill){
                self.comboBar!.removeAction(forKey: "Combo")
                self.run(SKAction.run({self.comboBar?.progressBar.setProgress(0.0)}))
                DashSkill()
                self.comboBar?.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run({self.comboBar!.startCombo()}) ]))
            }
            else if(skill == .projectileSkill){
                self.comboBar!.removeAction(forKey: "Combo")
                ProjectileSkill()
                self.comboBar?.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run({self.comboBar!.startCombo() }) ]))
            }
            if(comboBar?.progressBar.maskNode?.xScale > 1.0){
                comboBar?.background.isHidden = true
                comboBar?.surround.isHidden = true
                comboActive = false
                comboBar!.progressBar.setProgress(0.0)
            }
        }else if(comboActive && (comboBar!.progressBar.maskNode?.xScale < comboBar!.lowThrash || comboBar!.progressBar.maskNode?.xScale > comboBar?.highThrash)){
            comboBar?.background.isHidden = true
            comboBar?.surround.isHidden = true
            comboActive = false
            self.comboBar!.removeAction(forKey: "Combo")
            comboBar!.progressBar.setProgress(0.0)

        }else if(!comboActive){
            if(skill == .dashSkill){
                DashSkill()
                
            }
            else if(skill == .projectileSkill){
                ProjectileSkill()
            }

        }
    }
    func isMonsterDead(_ hp:Double,projectile:SKSpriteNode){
        view!.isUserInteractionEnabled = true
        if (hp <= 0.0) {
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                ()
            })
            projectile.removeFromParent()
            GameScene.level = GameScene.level! + 1
            
            let defaults = UserDefaults.standard
            defaults.set(GameScene.level!, forKey: "maxLevel")
            
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            
            let gameOverScene = GameOverScene(size: self.size, won: true)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
    }
}
