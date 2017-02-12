//
//  GlowNode.swift
//  Attraction
//
//  Created by Nikola Bozhkov on 12/7/16.
//  Copyright © 2016 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class GlowNode: SKSpriteNode {
    let glow: SKSpriteNode
    
    init(texture: SKTexture, glowTexture: SKTexture) {
        self.glow = SKSpriteNode(texture: glowTexture, color: .clear, size: glowTexture.size())
        self.glow.position = .zero
        self.glow.zPosition = -20

        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.addChild(self.glow)
        setGlow(from: 0.5, to: 1, duration: 1.2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGlow(from: CGFloat, to: CGFloat, duration: TimeInterval) {
        self.glow.removeAllActions()
        
        self.glow.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.fadeAlpha(to: from, duration: duration),
            SKAction.fadeAlpha(to: to, duration: duration)])))
    }
}
