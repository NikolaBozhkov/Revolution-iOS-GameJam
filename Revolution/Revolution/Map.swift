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
        self.mainCity = City(direction: 0, tier: 0, enemy: 100, texture: nil, position: .zero)
        
        super.init()
        self.addChild(self.mainCity)
        
        let angle = CGFloat(M_PI * 2) / CGFloat(directions)
        let startAngle = CGFloat(M_PI / 4)
        let tier3Num = 3
        let tier3Angle = CGFloat(M_PI * 2) / CGFloat(tier3Num + 1)
        var tier1Cities: [City] = []
        var tier2Cities: [City] = []
        for i in 1...directions {
            let posNormal = CGPoint(angle: CGFloat(i) * angle + startAngle)
            var position = posNormal * 150
            let tier1City = City(direction: i, tier: 1, enemy: 50, texture: nil, position: position)
            tier1Cities.append(tier1City)
            self.addChild(tier1City)
            
            // Add connections tier1 - tier0
            self.mainCity.connections.append(Connection(destination: tier1City, distance: 20))
            tier1City.connections.append(Connection(destination: self.mainCity, distance: 20))
            
            position = posNormal * 250
            let tier2City = City(direction: i, tier: 2, enemy: 25, texture: SKTexture(imageNamed: "castle"), position: position)
            tier2Cities.append(tier2City)
            self.addChild(tier2City)
            
            // Add connections tier1 - tier2
            tier1City.connections.append(Connection(destination: tier2City, distance: 10))
            tier2City.connections.append(Connection(destination: tier1City, distance: 10))
            
            for j in 0..<tier3Num {
                
                let innerAngle = CGFloat(i) * angle + startAngle - tier3Angle + tier3Angle * CGFloat(j)
                let innerPosition = position + CGPoint(angle: innerAngle) * 90
                let tier3City = City(direction: i, tier: 3, enemy: 10, texture: nil, position: innerPosition)
                self.addChild(tier3City)
                
                // Add connections between tier3 cities and tier2 city
                tier2City.connections.append(Connection(destination: tier3City, distance: 5))
                tier3City.connections.append(Connection(destination: tier2City, distance: 5))
            }
        }
        
        // Add connections between tier1
        for city in tier1Cities {
            for otherCity in tier1Cities {
                if city.direction == directions {
                    if otherCity.direction == 1 || otherCity.direction == directions - 1 {
                        city.connections.append(Connection(destination: otherCity, distance: 30))
                    }
                } else if city.direction == 1 {
                    if otherCity.direction == directions || otherCity.direction == 2 {
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
                if city.direction == directions {
                    if otherCity.direction == 1 || otherCity.direction == directions - 1 {
                        city.connections.append(Connection(destination: otherCity, distance: 60))
                    }
                } else if city.direction == 1 {
                    if otherCity.direction == directions || otherCity.direction == 2 {
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
