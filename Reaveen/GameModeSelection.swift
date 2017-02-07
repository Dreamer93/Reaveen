//
//  GameModeSelection.swift
//  reaveen
//
//  Created by temp on 21/09/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

//import UIKit

//class GameModeSelection: NSObject {

//}
//
//  GameModeSelection.swift
//  reaveen
//
//  Created by temp on 21/09/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//
//
//  SettingsMenuScene.swift
//  Reaveen
//
//  Created by Matic Vrenko on 03/02/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//


 import UIKit
 import SpriteKit
 
 class GameModeSelection: SKScene {
 
 override func didMove(to view: SKView) {
 
 let label = SKLabelNode(fontNamed: "Chalkduster")
 label.text = "Select Game mode(left= new game, right = saved game)"
 label.fontSize = 40
 label.fontColor = SKColor.black
 label.position = CGPoint(x: size.width/2, y: size.height*0.3)
 addChild(label)
 
 let playGameButton: UIButton = UIButton(defaultButtonImage: "buttonTextureDefault", activeButtonImage: "buttonTextureActive", buttonAction: goToGameSceneSaved)
 playGameButton.position = CGPoint(x: self.frame.width / 4, y: self.frame.height / 2)
 addChild(playGameButton)
 
 
 
 let playNewGame: UIButton = UIButton(defaultButtonImage: "buttonTextureDefault", activeButtonImage: "buttonTextureActive", buttonAction: goToGameSceneNew)
 playNewGame.position = CGPoint(x: 3*self.frame.width / 4, y: self.frame.height / 2)
 addChild(playNewGame)
 
 let goBackButton: UIButton = UIButton(defaultButtonImage: "b", activeButtonImage: "b", buttonAction: goToMainMenu)
 goBackButton.position = CGPoint( x: 7*self.frame.width / 8, y: self.frame.height / 1.5)
 addChild(goBackButton)
 
 }
 
 
 func goToMainMenu () {
 let newScene = MainMenuScene(fileNamed: "MainMenuScene")!
 newScene.scaleMode = .fill
 self.view?.presentScene(newScene, transition: SKTransition.doorsCloseHorizontal(withDuration: 0.35))
 }
 
 
 func goToGameSceneSaved () {
 let endScene = GameScene(fileNamed: "GameScene")! //Replace here with the target scene
 endScene.scaleMode = .fill
 self.view?.presentScene(endScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 0.35)) // Performs the transition of scene if the button was touch
 }
 func goToGameSceneNew () {
 let endScene = GameScene(fileNamed: "GameScene")! //Replace here with the target scene
 endScene.scaleMode = .fill
 self.view?.presentScene(endScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 0.35)) // Performs the transition of scene if the button was touch
 let defaults = UserDefaults.standard
 defaults.set(1, forKey: "maxLevel")
 
 }
 
 }
