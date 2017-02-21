//
//  Enemy.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import CoreGraphics

class Enemy {
    
    static var power: CGFloat!
    static var speed: CGFloat!
    static var detection: CGFloat!
    
    class func initialize() {
        power = 4
        speed = 2
        detection = 1
    }
}
