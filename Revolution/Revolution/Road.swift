//
//  Roadf.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/11/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class Road: SKSpriteNode {
    
    let cityOne: City
    let cityTwo: City
    let distance: CGFloat
    let deltaNormal: CGPoint
    
    var messageUnits: Set<MessageUnit> = []
    var enemyUnits: Set<EnemyUnit> = []
    var playerUnits: Set<PlayerUnit> = []
    
    init(cityOne: City, cityTwo: City) {
        self.cityOne = cityOne
        self.cityTwo = cityTwo
        self.distance = cityTwo.position.distanceTo(cityOne.position)
        self.deltaNormal = (cityTwo.position - cityOne.position).normalized()
        
        super.init(texture: nil, color: UIColor(hex: "524938"), size: CGSize(width: self.distance, height: 4))
        
        self.blendMode = .add
        self.alpha = 0.5
        self.zPosition = 50
        
        self.position = cityOne.position + deltaNormal * distance / 2
        self.zRotation = atan(deltaNormal.y / deltaNormal.x)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(deltaT: CGFloat) {
        
        for playerUnit in self.playerUnits {
            playerUnit.update(deltaT: deltaT)
        }
        
        for messageUnit in self.messageUnits {
            messageUnit.update(deltaT: deltaT)
            
            for playerUnit in self.playerUnits {
                if checkUnitIntersepcion(unitOne: playerUnit, unitTwo: messageUnit) {
                    messageUnit.remove()
                }
            }
        }
        
        for enemyUnit in self.enemyUnits {
            enemyUnit.update(deltaT: deltaT)
            
            for playerUnit in self.playerUnits {
                if checkUnitIntersepcion(unitOne: playerUnit, unitTwo: enemyUnit) {
                    let enemyKills = CGFloat(playerUnit.count) * Player.power / 7
                    let playerKills = CGFloat(enemyUnit.count) * Enemy.power / 7
                    
                    //FIX LATER, MUST KILL UNITS
                    
                    playerUnit.count -= Int(playerKills)
                    enemyUnit.count -= Int(enemyKills)
                    
                    if playerUnit.count <= 0 {
                        playerUnit.remove()
                    }
                    
                    if enemyUnit.count <= 0 {
                        enemyUnit.remove()
                    }
                }
            }
        }
    }
    
    func checkUnitIntersepcion(unitOne: RoadUnit, unitTwo: RoadUnit) -> Bool {
        let disUnitOne = unitOne.currentSource.position.distanceTo(unitOne.position)
        let disUnitOnePrev = unitOne.currentSource.position.distanceTo(unitOne.prevPosition)
        let disUnitTwo = unitTwo.currentSource.position.distanceTo(unitTwo.position)
        let disUnitTwoPrev = unitTwo.currentSource.position.distanceTo(unitTwo.prevPosition)
        
        if (unitOne.currentTarget == unitTwo.currentTarget && (disUnitOne - disUnitTwo) * (disUnitOnePrev - disUnitTwoPrev) <= 0)
            || (unitOne.currentTarget != unitTwo.currentTarget && disUnitOne + disUnitTwo >= distance) {
            
            return true
        } else {
            return false
        }
    }
}
