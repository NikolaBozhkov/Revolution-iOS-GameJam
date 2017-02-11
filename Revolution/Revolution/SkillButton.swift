//
//  SkillButton.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/11/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class SkillButton: SKNode {
    
    var skillValue: Int
    var skillValueLabel: SKLabelNode!
    
    init(name: String, icon: SKTexture, skillValue: Int) {
        self.skillValue = skillValue
        
        super.init()
        
        self.skillValueLabel = self.childNode(withName: "skillValueLabel") as! SKLabelNode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
