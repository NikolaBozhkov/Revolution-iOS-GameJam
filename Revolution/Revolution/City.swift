//
//  City.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class City: SKSpriteNode {

    var tier: Int
    var direction: Int
    
    var enemy: Int
    var player: Int
    var suspicion: CGFloat = 0
    
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
        
        super.init(texture: texture, color: color , size: texture == nil ? CGSize(width: 50, height: 50) : texture!.size())
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        // Increase suspicion percentage
        
        // If war, kill percentage of each population
        // if NOT war, convert % of enemy to player
    }
}
