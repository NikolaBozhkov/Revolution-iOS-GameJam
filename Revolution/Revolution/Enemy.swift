//
//  Enemy.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import Foundation

class Enemy: Entity {
    
    var detection: Int
    
    init() {
        self.detection = 10
        super.init(power: 10, diplomacy: 10, speed: 10)
    }
}
