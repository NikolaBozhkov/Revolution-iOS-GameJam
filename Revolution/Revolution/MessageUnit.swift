//
//  MessageUnit.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/12/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class MessageUnit: RoadUnit {
    
    var helpLocation: City
    
    init(paths: [(road: Road, source: City, target: City)], totalDistance: CGFloat, count: Int, texture: SKTexture?, helpLocation: City) {
        self.helpLocation = helpLocation
        super.init(paths: paths, totalDistance: totalDistance, count: count, texture: texture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromRoad() {
        currentRoad.messageUnits.remove(self)
    }
    
    override func moveNextRoad() {
         super.moveNextRoad()
    }
    
    override func addToRoad() {
        currentRoad.messageUnits.insert(self)
    }
    
    override func getSpeed() -> CGFloat {
        return Enemy.speed * 4
    }
}
