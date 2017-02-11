//
//  Map.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class Map: SKNode {
    
    let cities: [City] = []
    let mainCity: City
    
    init(directions: Int = 4) {
        self.mainCity = City(direction: 0, tier: 0, enemy: 100, texture: SKTexture(imageNamed: "Capital"), position: CGPoint(x: 0, y: -20))
        
        super.init()
        self.addChild(self.mainCity)
        
        let angle = CGFloat.pi * 2 / CGFloat(directions)
        let startAngle = CGFloat.pi / 6
        let tier3Num = 3
        let tier3Angle = CGFloat.pi / 3
        var tier1Cities: [City] = []
        var tier2Cities: [City] = []
        for i in 0..<directions {
            let angleMod = i % 2 != 0 ? CGFloat.pi / 2 - startAngle * 2 : 0
            let currentAngle = CGFloat(i) * angle + startAngle + angleMod
            let posNormal = CGPoint(angle: currentAngle)
            var position = posNormal * 210
            let tier1City = City(direction: i, tier: 1, enemy: 50, texture: SKTexture(imageNamed: "tier1"), position: position + mainCity.position)
            tier1Cities.append(tier1City)
            self.addChild(tier1City)
            
            // Add connections tier1 - tier0
            self.mainCity.connections.append(Connection(destination: tier1City, distance: 20))
            tier1City.connections.append(Connection(destination: self.mainCity, distance: 20))
            
            position = posNormal * 350
            let tier2City = City(direction: i, tier: 2, enemy: 25, texture: SKTexture(imageNamed: "tier2"), position: position + mainCity.position)
            tier2Cities.append(tier2City)
            self.addChild(tier2City)
            
            // Add connections tier1 - tier2
            tier1City.connections.append(Connection(destination: tier2City, distance: 10))
            tier2City.connections.append(Connection(destination: tier1City, distance: 10))
            
            for j in 0..<tier3Num {
                
                let innerAngle = currentAngle - tier3Angle + tier3Angle * CGFloat(j)
                let innerPosition = position + CGPoint(angle: innerAngle) * 110
                let tier3City = City(direction: i, tier: 3, enemy: 10, texture: SKTexture(imageNamed: "tier3"), position: innerPosition + mainCity.position)
                self.addChild(tier3City)
                
                // Add connections between tier3 cities and tier2 city
                tier2City.connections.append(Connection(destination: tier3City, distance: 5))
                tier3City.connections.append(Connection(destination: tier2City, distance: 5))
            }
        }
        
        // Add connections between tier1
        for city in tier1Cities {
            for otherCity in tier1Cities {
                if city.direction == directions - 1 {
                    if otherCity.direction == 0 || otherCity.direction == city.direction - 1 {
                        city.connections.append(Connection(destination: otherCity, distance: 30))
                    }
                } else if city.direction == 0 {
                    if otherCity.direction == directions - 1 || otherCity.direction == city.direction + 1 {
                        city.connections.append(Connection(destination: otherCity, distance: 30))
                    }
                } else {
                    if otherCity.direction == city.direction - 1 || otherCity.direction == city.direction + 1 {
                        city.connections.append(Connection(destination: otherCity, distance: 30))
                    }
                }
            }
        }
        
        // Add connections between tier2
        for city in tier2Cities {
            for otherCity in tier2Cities {
                if city.direction == directions - 1 {
                    if otherCity.direction == 0 || otherCity.direction == city.direction - 1 {
                        city.connections.append(Connection(destination: otherCity, distance: 60))
                    }
                } else if city.direction == 0 {
                    if otherCity.direction == directions - 1 || otherCity.direction == city.direction + 1 {
                        city.connections.append(Connection(destination: otherCity, distance: 60))
                    }
                } else {
                    if otherCity.direction == city.direction - 1 || otherCity.direction == city.direction + 1 {
                        city.connections.append(Connection(destination: otherCity, distance: 60))
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
