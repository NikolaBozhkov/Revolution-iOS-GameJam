//
//  City.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class City: SKSpriteNode {
    
    static let suspicionDropRate: CGFloat = 1

    var tier: Int
    var direction: Int
    
    var enemy: Int
    var player: Int
    var suspicion: CGFloat = 0
    
    var currentConverted: CGFloat = 0
    var currentEnemyKilled: CGFloat = 0
    var currentPlayerKilled: CGFloat = 0
    
    var connections: [Connection] = []
    
    init(direction: Int, tier: Int, enemy: Int, texture: SKTexture?, position: CGPoint) {
        
        self.tier = tier
        self.direction = direction
        self.enemy = enemy
        self.player = 0
        
        var color: UIColor!
        
        if tier == 0 {
            color = .red
        } else if tier == 1 {
            color = .blue
        } else if tier == 2 {
            color = .purple
        } else if tier == 3 {
            color = .yellow
        }
        
        super.init(texture: texture == nil ? SKTexture(imageNamed: "circleBase") : texture, color: color , size: texture == nil ? CGSize(width: 50, height: 50) : texture!.size())
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(deltaT: CGFloat) {
        let populationRatio = enemy != 0 ? CGFloat(player) / CGFloat(enemy) : 0
        
        // Increase suspicion percentage by population ratio and stealth level
        let suspicionMod = (Enemy.detection - Player.stealth).clamped(0, 1)
        suspicion += populationRatio * suspicionMod * deltaT
        
        if suspicionMod == 0 || player == 0 {
            suspicion -= City.suspicionDropRate * deltaT
        }
        
        suspicion.clamp(0, 1)
        
        // If war, kill percentage of each population
        if suspicion == 1 {
            currentEnemyKilled += populationRatio * (Player.power - Enemy.power).clamped(0, Player.power) * deltaT
            currentPlayerKilled += 1 / populationRatio * (Enemy.power - Player.power).clamped(0, Enemy.power) * deltaT
            
            if currentEnemyKilled >= 1 {
                let enemyKilled = currentEnemyKilled.rounded(.down).clamped(0, CGFloat(enemy))
                enemy -= Int(enemyKilled)
                currentEnemyKilled -= enemyKilled
            }
            
            if currentPlayerKilled >= 1 {
                let playerKilled = currentPlayerKilled.rounded(.down).clamped(0, CGFloat(player))
                player -= Int(playerKilled)
                currentPlayerKilled -= playerKilled
            }
        } else if enemy != 0 {
            // if NOT war, convert % of enemy to player
            currentConverted += populationRatio * Player.diplomacy * deltaT
            
            if currentConverted >= 1 {
                // Get num of converted people with max being the enemy population
                let convertNum = currentConverted.rounded(.down).clamped(0, CGFloat(enemy))
                
                enemy -= Int(convertNum)
                player += Int(convertNum)
                currentConverted -= convertNum
            }
        }
    }
}
