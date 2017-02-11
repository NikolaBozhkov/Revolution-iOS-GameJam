//
//  MainScene.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class MainScene: SKScene {
    
    var cities: [City]!

    override func didMove(to view: SKView) {
        let map = Map()
        
        self.addChild(map)
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
