//
//  PopulationLabel.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/11/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class PopulationLabel: SKNode {
    
    var countLabel: SKLabelNode
    var icon: SKSpriteNode
    
    init(horizontalAlignmentMode: SKLabelHorizontalAlignmentMode, position: CGPoint, isEnemy: Bool) {
        self.countLabel = SKLabelNode(fontNamed: "MotionControl-Bold")
        self.countLabel.horizontalAlignmentMode = horizontalAlignmentMode
        self.countLabel.verticalAlignmentMode = .center
        self.countLabel.fontSize = 28
        self.countLabel.fontColor = isEnemy ? UIColor(hex: "ffad94") : UIColor(hex: "ffce89")
        
        var iconTexture: SKTexture!
        if isEnemy {
            iconTexture = SKTexture(imageNamed: "Enemy")
        } else {
            iconTexture = SKTexture(imageNamed: "Revolutioner")
        }
        
        var direction: CGFloat = 1
        var anchorPoint: CGPoint!
        
        if horizontalAlignmentMode == .left {
            anchorPoint = CGPoint(x: 0, y: 0.5)
        } else {
            direction = -1
            anchorPoint = CGPoint(x: 1, y: 0.5)
        }
        
        self.icon = SKSpriteNode(texture: iconTexture)
        self.icon.anchorPoint = anchorPoint
        self.icon.position = CGPoint(x: 3 * direction, y: 0)
        
        self.countLabel.position = self.icon.position + CGPoint(x: 18 * direction, y: 0)
        
        super.init()
        self.addChild(self.icon)
        self.addChild(self.countLabel)
    }
    
    override init() {
        countLabel = SKLabelNode()
        icon = SKSpriteNode()
        
        super.init()
    }
    
    init(_ label: PopulationLabel) {
        self.countLabel = label.countLabel.copy() as! SKLabelNode
        self.icon = label.icon.copy() as! SKSpriteNode
        
        super.init()
        
        self.position = label.position
        
        self.addChild(self.icon)
        self.addChild(self.countLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
