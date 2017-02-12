//
//  SkillButton.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/11/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class SkillButton: SKSpriteNode {
    
    var skillValue: Int = 0 {
        didSet {
            if name == "power" {
                Player.power = CGFloat(skillValue)
            } else if name == "diplomacy" {
                Player.diplomacy = CGFloat(skillValue)
            } else if name == "speed" {
                Player.speed = CGFloat(skillValue)
            } else if name == "stealth" {
                Player.stealth = CGFloat(skillValue)
            }
        }
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        if name == "power" {
            skillValue = Int(Player.power)
        } else if name == "diplomacy" {
            skillValue = Int(Player.diplomacy)
        } else if name == "speed" {
            skillValue = Int(Player.speed)
        } else if name == "stealth" {
            skillValue = Int(Player.stealth)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
