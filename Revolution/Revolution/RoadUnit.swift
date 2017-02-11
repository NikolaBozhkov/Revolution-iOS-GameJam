//
//  RoadUnit.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/11/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class RoadUnit: SKSpriteNode {
    
    let target: City
    var positionFraction: CGFloat = 0
    var positionFractionPrev: CGFloat = 0
    var count: Int
    
    init(target: City, count: Int, texture: SKTexture?) {
        self.target = target
        self.count = count
        
        super.init(texture: nil, color: .red, size: texture == nil ? CGSize(width: 20, height: 20) : texture!.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
