//
//  Player.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import CoreGraphics

class Player: Entity {
    
    static var stealth: CGFloat!
    
    static func initialize() {
        initialize(power: 0, diplomacy: 0, speed: 0)
        self.stealth = 0
    }
}
