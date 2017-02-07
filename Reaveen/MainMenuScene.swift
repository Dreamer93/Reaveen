//
//  MainMenuScene.swift
//  Reaveen
//
//  Created by Matic Vrenko on 03/02/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
class MainMenuScene: SKScene {

    override func didMove(to view: SKView) {
        
        playBackgroundMusic("Led Zeppelin- Stairway to Heaven with Lyrics.mp3")
        
        let sign = SKLabelNode(fontNamed: "Chalkduster")
        sign.text = "Where it's up to you"
        sign.fontSize = 20
        sign.fontColor = SKColor.black
        sign.position = CGPoint(x: size.width/2, y: size.height*0.25)
        addChild(sign)
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Reaveen's Destiny"
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height*0.3)
        addChild(label)
        
        let playGameButton: UIButton = UIButton(defaultButtonImage: "buttonTextureDefault", activeButtonImage: "buttonTextureActive", buttonAction: goToChooseGame)
        playGameButton.position = CGPoint(x: self.frame.width / 4, y: self.frame.height / 2)
        addChild(playGameButton)
        
        
        
        let settingsButton: UIButton = UIButton(defaultButtonImage: "buttonTextureDefault", activeButtonImage: "buttonTextureActive", buttonAction: goToSettingsScene)
        settingsButton.position = CGPoint(x: 3*self.frame.width / 4, y: self.frame.height / 2)
        addChild(settingsButton)
    }
    var backgroundMusicPlayer = AVAudioPlayer()
    
    func playBackgroundMusic(_ filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func goToChooseGame () {
        let endScene = GameModeSelection(fileNamed: "GameModeSelection")! //Replace here with the target scene
        endScene.scaleMode = .aspectFill
        self.view?.presentScene(endScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 0.35)) // Performs the transition of scene if the button was touch
        backgroundMusicPlayer.stop()

    }

    func goToSettingsScene () {
        let endScene = SettingsMenuScene(fileNamed: "SettingsMenuScene")! //Replace here with the target scene
        endScene.scaleMode = .aspectFill
        self.view?.presentScene(endScene, transition: SKTransition.push(with: .up, duration: 0.35)) // Performs the transition of scene if the button was touch
        backgroundMusicPlayer.stop()

    }
    
}
