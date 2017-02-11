//
//  Player.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import Foundation

class Player: Entity {
    
    var stealth: Int
    
    init() {
        self.stealth = 10
        super.init(power: 0, diplomacy: 0, speed: 0)
    }
}
