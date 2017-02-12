//
//  Player.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class Player {
    
    static var power: CGFloat = 0 {
        didSet {
            self.powerLabel.text = String(describing: Int(power))
        }
    }
    static var diplomacy: CGFloat = 0 {
        didSet {
            self.diplomacyLabel.text = String(describing: Int(diplomacy))
        }
    }
    static var speed: CGFloat = 0 {
        didSet {
            self.speedLabel.text = String(describing: Int(speed))
        }
    }
    static var stealth: CGFloat = 0 {
        didSet {
            self.stealthLabel.text = String(describing: Int(stealth))
        }
    }
    
    static var initialPeople: Int = 0
    
    static var powerLabel: SKLabelNode!
    static var diplomacyLabel: SKLabelNode!
    static var speedLabel: SKLabelNode!
    static var stealthLabel: SKLabelNode!
    
    static func initialize(powerLabel: SKLabelNode, diplomacyLabel: SKLabelNode, speedLabel: SKLabelNode, stealthLabel: SKLabelNode) {
        self.powerLabel = powerLabel
        self.diplomacyLabel = diplomacyLabel
        self.speedLabel = speedLabel
        self.stealthLabel = stealthLabel
        
        self.power = 5
        self.diplomacy = 5
        self.speed = 5
        self.stealth = 5
        self.initialPeople = 10
    }
}
