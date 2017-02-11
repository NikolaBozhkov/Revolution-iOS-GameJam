//
//  Enemy.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import CoreGraphics

class Enemy: Entity {
    
    static var detection: CGFloat!
    
    class func initialize() {
        initialize(power: 10, diplomacy: 10, speed: 10)
        self.detection = 10
    }
}
