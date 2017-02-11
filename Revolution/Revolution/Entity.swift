//
//  Entity.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import Foundation

class Entity {
    
    var power: Int
    var diplomacy: Int
    var speed: Int
    
    init(power: Int, diplomacy: Int, speed: Int) {
        self.power = power
        self.diplomacy = diplomacy
        self.speed = speed
    }
}
