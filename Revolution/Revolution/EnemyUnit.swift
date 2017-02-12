//
//  EnemyUnit.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/12/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import CoreGraphics

class EnemyUnit: RoadUnit {
    
    override func removeFromRoad() {
        currentRoad.enemyUnits.remove(self)
    }
    
    override func moveNextRoad() {
        super.moveNextRoad()
    }
    
    override func addToRoad() {
        currentRoad.enemyUnits.insert(self)
    }
    
    override func getSpeed() -> CGFloat {
        return Enemy.speed * 40
    }
}
