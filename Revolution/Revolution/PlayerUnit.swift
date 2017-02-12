//
//  PlayerUnit.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/12/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import CoreGraphics

class PlayerUnit: RoadUnit {
    
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
        return Player.speed * 40
    }
}
