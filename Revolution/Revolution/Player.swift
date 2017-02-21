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
    
    static var coins: Int = 0 {
        didSet {
            self.coinsLabel.text = String(coins)
        }
    }
    
    static var initialPeople: Int = 0
    
    static var powerLabel: SKLabelNode!
    static var diplomacyLabel: SKLabelNode!
    static var speedLabel: SKLabelNode!
    static var stealthLabel: SKLabelNode!
    static var coinsLabel: SKLabelNode!
    
    static func initialize(powerLabel: SKLabelNode, diplomacyLabel: SKLabelNode, speedLabel: SKLabelNode, stealthLabel: SKLabelNode, coinsLabel: SKLabelNode) {
        self.powerLabel = powerLabel
        self.diplomacyLabel = diplomacyLabel
        self.speedLabel = speedLabel
        self.stealthLabel = stealthLabel
        self.coinsLabel = coinsLabel
        
        self.power = 1
        self.diplomacy = 1
        self.speed = 2
        self.stealth = 3
        self.initialPeople = 5
    }
    
    static func levelUp(skill: String) {
        if coins > 0 {
            if skill == "power" {
                Player.power.add(1)
            } else if skill == "diplomacy" {
                Player.diplomacy.add(1)
            } else if skill == "speed" {
                Player.speed.add(1)
            } else if skill == "stealth" {
                Player.stealth.add(1)
            }
            
            coins -= 1
        }
    }
}
