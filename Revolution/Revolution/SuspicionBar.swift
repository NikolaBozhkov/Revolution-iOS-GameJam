//
//  SuspicionBar.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/12/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class SuspicionBar: SKNode {
    
    let leftCap: SKSpriteNode
    let rightCap: SKSpriteNode
    let mid: SKSpriteNode
    
    var percent: CGFloat = 0 {
        didSet {
            mid.xScale = percent - 0.02
            
            if percent > 0 {
                leftCap.isHidden = false
            } else {
                leftCap.isHidden = true
            }
            
            if percent == 1 {
                rightCap.isHidden = false
            } else {
                rightCap.isHidden = true
            }
        }
    }
    
    init(width: CGFloat, position: CGPoint) {
        self.leftCap = SKSpriteNode(texture: Resources.suspicionBarLeftTexture)
        self.leftCap.yScale = 1.5
        self.leftCap.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.leftCap.position = CGPoint(x: -width / 2, y: 0)
        self.leftCap.zPosition = 200
        self.rightCap = SKSpriteNode(texture: Resources.suspicionBarLeftTexture)
        self.rightCap.xScale = -1
        self.rightCap.yScale = 1.5
        self.rightCap.zPosition = 200
        self.rightCap.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.rightCap.position = CGPoint(x: width / 2, y: 0)
        
        self.mid = SKSpriteNode(texture: Resources.suspicionBarMidTexture)
        self.mid.size.width = self.rightCap.position.distanceTo(self.leftCap.position)
        self.mid.yScale = 1.5
        self.mid.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.mid.position = CGPoint(x: -self.mid.size.width / 2, y: 0)
        self.mid.xScale = 0
        self.mid.zPosition = 201
        
        self.leftCap.isHidden = true
        self.rightCap.isHidden = true
        
        let bg = SKSpriteNode(texture: Resources.suspicionBarBgTexture,
                              size: CGSize(width: width, height: Resources.suspicionBarBgTexture.size().height * 1.5))
        bg.zPosition = 199
        let icon = SKSpriteNode(texture: Resources.suspicionBarIconTexture)
        icon.zPosition = 199
        icon.setScale(1.5)
        icon.anchorPoint = CGPoint(x: 1, y: 0.5)
        icon.position = CGPoint(x: -bg.size.width / 2, y: 0)
        
        super.init()
        
        self.position = position
        self.addChild(bg)
        self.addChild(leftCap)
        self.addChild(rightCap)
        self.addChild(mid)
        self.addChild(icon)
        
        print(self.leftCap.position, self.rightCap.position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
