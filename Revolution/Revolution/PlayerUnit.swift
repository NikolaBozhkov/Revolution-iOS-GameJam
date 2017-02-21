//
//  PlayerUnit.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/12/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class PlayerUnit: RoadUnit {
    
    override init(paths: [(road: Road, source: City, target: City)], totalDistance: CGFloat, count: Int, texture: SKTexture?) {
        super.init(paths: paths, totalDistance: totalDistance, count: count, texture: texture)
        
        let countLabel = SKLabelNode(text: String(count))
        countLabel.verticalAlignmentMode = .bottom
        countLabel.position += CGPoint(x: 0, y: Resources.playerTexture.size().height / 2)
        countLabel.fontName = "MotionControl-Bold"
        countLabel.fontSize = 27
        countLabel.fontColor = UIColor(hex: "ffce89")
        
        self.addChild(countLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromRoad() {
        currentRoad.playerUnits.remove(self)
    }
    
    override func moveNextRoad() {
        super.moveNextRoad()
    }
    
    override func addToRoad() {
        currentRoad.playerUnits.insert(self)
    }
    
    override func getSpeed() -> CGFloat {
        return Player.speed * 8
    }
}
