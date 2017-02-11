//
//  Roadf.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/11/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class Road {
    
    let cityOne: City
    let cityTwo: City
    let distance: CGFloat
    let deltaNormal: CGPoint
    
    var messages: Set<RoadUnit> = []
    var enemyUnits: Set<RoadUnit> = []
    var playerUnits: Set<RoadUnit> = []
    
    init(cityOne: City, cityTwo: City) {
        self.cityOne = cityOne
        self.cityTwo = cityTwo
        self.distance = cityOne.position.distanceTo(cityTwo.position)
        self.deltaNormal = (cityOne.position - cityTwo.position).normalized()
    }
    
    func update(deltaT: CGFloat) {
        for playerUnit in self.playerUnits {
            moveRoadUnit(playerUnit, moveFraction: Player.speed * deltaT)
        }
        
        for message in self.messages {
            moveRoadUnit(message, moveFraction: Enemy.speed * deltaT)
            
            // Check if player intersected it
            for playerUnit in self.playerUnits {
                if self.checkUnitIntersepcion(unitOne: message, unitTwo: playerUnit) {
                    messages.remove(message)
                }
            }
        }
        
        for enemyUnit in self.enemyUnits {
            moveRoadUnit(enemyUnit, moveFraction: Enemy.speed * deltaT)
            
            // Check if enemy intersected with player
            for playerUnit in self.playerUnits {
                if self.checkUnitIntersepcion(unitOne: enemyUnit, unitTwo: playerUnit) {
                    let playerFactor = CGFloat(playerUnit.count) * Player.power
                    let enemyFactor = CGFloat(enemyUnit.count) * Enemy.power
                    
                    if playerFactor >= enemyFactor {
                        self.enemyUnits.remove(enemyUnit)
                    }
                    
                    if enemyFactor >= playerFactor {
                        self.playerUnits.remove(playerUnit)
                    }
                }
            }
        }
    }
    
    func moveRoadUnit(_ roadUnit: RoadUnit, moveFraction: CGFloat) {
        roadUnit.positionFractionPrev = roadUnit.positionFraction
        roadUnit.positionFraction += moveFraction
        roadUnit.position = (self.deltaNormal * self.distance) * roadUnit.positionFraction
    }
    
    func checkUnitIntersepcion(unitOne: RoadUnit, unitTwo: RoadUnit) -> Bool {
        let posFractionPrevDelta = unitOne.positionFractionPrev - unitTwo.positionFractionPrev
        let posFractionDelta = unitOne.positionFraction - unitTwo.positionFraction
        let posFractionSign = posFractionDelta * posFractionPrevDelta
        let posFractionPrevSum = unitOne.positionFractionPrev + unitTwo.positionFractionPrev
        let posFractionSum = unitOne.positionFraction + unitTwo.positionFraction
        
        // If they crossed paths or if some caught up to the other
        if (unitTwo.target == unitOne.target && posFractionSign < 0)
            || (unitTwo.target != unitOne.target && posFractionPrevSum < 1 && posFractionSum >= 1) {
            
            return true
        }
        
        return false
    }
}
