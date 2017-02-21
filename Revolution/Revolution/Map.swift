//
//  Map.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class Map: SKNode {
    
    var tierOneCities = Set<City>()
    var tierTwoCities = Set<City>()
    var tierThreeCities = Set<City>()
    let mainCity: City
    var roads = Set<Road>()
    var roadUnits = Set<RoadUnit>()
    
    init(directions: Int = 4) {
        self.mainCity = City(direction: 0, tier: 0, enemy: 50, texture: SKTexture(imageNamed: "capital_base"),
                             textureGlow: SKTexture(imageNamed: "capital_glow"), position: CGPoint(x: 0, y: -20))
        
        super.init()
        self.addChild(self.mainCity)
        
        let angle = CGFloat.pi * 2 / CGFloat(directions)
        let startAngle = CGFloat.pi / 6
        let tier3Num = 3
        let tier3Angle = CGFloat.pi / 3
        
        for i in 0..<directions {
            let angleMod = i % 2 != 0 ? CGFloat.pi / 2 - startAngle * 2 : 0
            let currentAngle = CGFloat(i) * angle + startAngle + angleMod
            let posNormal = CGPoint(angle: currentAngle)
            var position = posNormal * 210
            let tier1City = City(direction: i, tier: 1, enemy: 25, texture: SKTexture(imageNamed: "tier1_base"),
                                 textureGlow: SKTexture(imageNamed: "tier1_glow"), position: position + mainCity.position)
            tierOneCities.insert(tier1City)
            self.addChild(tier1City)
            
            // Add connections tier1 - tier0
            var road = Road(cityOne: self.mainCity, cityTwo: tier1City)
            self.roads.insert(road)
            self.mainCity.roads.insert(road)
            tier1City.roads.insert(road)
            
            position = posNormal * 350
            let tier2City = City(direction: i, tier: 2, enemy: 10, texture: SKTexture(imageNamed: "tier2_base"),
                                 textureGlow: SKTexture(imageNamed: "tier2_glow"), position: position + mainCity.position)
            tierTwoCities.insert(tier2City)
            self.addChild(tier2City)
            
            // Add connections tier1 - tier2
            road = Road(cityOne: tier1City, cityTwo: tier2City)
            self.roads.insert(road)
            tier1City.roads.insert(road)
            tier2City.roads.insert(road)
            
            for j in 0..<tier3Num {
                
                let innerAngle = currentAngle - tier3Angle + tier3Angle * CGFloat(j)
                let innerPosition = position + CGPoint(angle: innerAngle) * 110
                let tier3City = City(direction: i, tier: 3, enemy: 7, texture: SKTexture(imageNamed: "tier3_base"),
                                     textureGlow: SKTexture(imageNamed: "tier3_glow"), position: innerPosition + mainCity.position)
                self.addChild(tier3City)
                self.tierThreeCities.insert(tier3City)
                
                // Add connections between tier3 cities and tier2 city
                road = Road(cityOne: tier2City, cityTwo: tier3City)
                self.roads.insert(road)
                tier2City.roads.insert(road)
                tier3City.roads.insert(road)
            }
        }
        
        // Add connections between tier1
        let tierOneD0 = tierOneCities.first(where: { $0.direction == 0 })!
        let tierOneD1 = tierOneCities.first(where: { $0.direction == 1 })!
        let tierOneD2 = tierOneCities.first(where: { $0.direction == 2 })!
        let tierOneD3 = tierOneCities.first(where: { $0.direction == 3 })!
        
        let roadTOne0to1 = Road(cityOne: tierOneD0, cityTwo: tierOneD1)
        let roadTOne1to2 = Road(cityOne: tierOneD1, cityTwo: tierOneD2)
        let roadTOne2to3 = Road(cityOne: tierOneD2, cityTwo: tierOneD3)
        let roadTOne3to0 = Road(cityOne: tierOneD3, cityTwo: tierOneD0)
        self.roads.insert(roadTOne0to1)
        self.roads.insert(roadTOne1to2)
        self.roads.insert(roadTOne2to3)
        self.roads.insert(roadTOne3to0)
        
        tierOneD0.roads.insert(roadTOne0to1)
        tierOneD0.roads.insert(roadTOne3to0)
        tierOneD1.roads.insert(roadTOne1to2)
        tierOneD1.roads.insert(roadTOne0to1)
        tierOneD2.roads.insert(roadTOne2to3)
        tierOneD2.roads.insert(roadTOne1to2)
        tierOneD3.roads.insert(roadTOne3to0)
        tierOneD3.roads.insert(roadTOne2to3)
        
        // Add connections between tier2
        let tierTwoD0 = tierTwoCities.first(where: { $0.direction == 0 })!
        let tierTwoD1 = tierTwoCities.first(where: { $0.direction == 1 })!
        let tierTwoD2 = tierTwoCities.first(where: { $0.direction == 2 })!
        let tierTwoD3 = tierTwoCities.first(where: { $0.direction == 3 })!
        
        let roadTTwo0to1 = Road(cityOne: tierTwoD0, cityTwo: tierTwoD1)
        let roadTTwo1to2 = Road(cityOne: tierTwoD1, cityTwo: tierTwoD2)
        let roadTTwo2to3 = Road(cityOne: tierTwoD2, cityTwo: tierTwoD3)
        let roadTTwo3to0 = Road(cityOne: tierTwoD3, cityTwo: tierTwoD0)
        self.roads.insert(roadTTwo0to1)
        self.roads.insert(roadTTwo1to2)
        self.roads.insert(roadTTwo2to3)
        self.roads.insert(roadTTwo3to0)
        
        tierTwoD0.roads.insert(roadTTwo0to1)
        tierTwoD0.roads.insert(roadTTwo3to0)
        tierTwoD1.roads.insert(roadTTwo1to2)
        tierTwoD1.roads.insert(roadTTwo0to1)
        tierTwoD2.roads.insert(roadTTwo2to3)
        tierTwoD2.roads.insert(roadTTwo1to2)
        tierTwoD3.roads.insert(roadTTwo3to0)
        tierTwoD3.roads.insert(roadTTwo2to3)
        
        self.addRoadsChildren()
    }
    
    func addRoadsChildren() {
        for road in roads {
            self.addChild(road)
        }
    }
    
    func update(deltaT: CGFloat) {
        mainCity.update(deltaT: deltaT)
        for city in tierOneCities {
            city.update(deltaT: deltaT)
        }
        
        for city in tierTwoCities {
            city.update(deltaT: deltaT)
        }
        
        for city in tierThreeCities {
            city.update(deltaT: deltaT)
        }
        
        for road in roads {
            road.update(deltaT: deltaT)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
