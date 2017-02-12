//
//  City.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class City: GlowNode {
    
    static let suspicionDropRate: CGFloat = 0.5

    var tier: Int
    var direction: Int
    
    var enemy: CGFloat {
        didSet {
            self.populationBar.setEnemyPopulation(enemy: Int(enemy), oldEnemy: Int(oldValue), animate: true)
        }
    }
    
    var player: CGFloat {
        didSet {
            self.populationBar.setPlayerPopulation(player: Int(player), oldPlayer: Int(oldValue), animate: true)
        }
    }
    
    var suspicion: CGFloat = 0
    var messageSent = false
    var helpLocations = Set<City>()
    
    var currentConverted: CGFloat = 0
    var currentEnemyKilled: CGFloat = 0
    var currentPlayerKilled: CGFloat = 0
    
    var roads = Set<Road>()
    
    var playerPercent: CGFloat {
        return CGFloat(player) / CGFloat(enemy + player)
    }
    
    // UI elements
    var populationBar: PopulationBar
    
    init(direction: Int, tier: Int, enemy: CGFloat, texture: SKTexture, textureGlow: SKTexture, position: CGPoint) {
        
        self.tier = tier
        self.direction = direction
        self.enemy = enemy
        self.player = 0
        
        var populationBarY: Int!
        
        if tier == 0 {
            populationBarY = -80
        } else if tier == 1 {
            populationBarY = -57
        } else if tier == 2 {
            populationBarY = -40
        } else if tier == 3 {
            populationBarY = -35
        }
        
        self.populationBar = PopulationBar(position: CGPoint(x: 0, y: populationBarY),
                                           enemyPopulation: Int(enemy), playerPopulation: 0)
        
        super.init(texture: texture, glowTexture: textureGlow)
        
        self.position = position
        self.addChild(self.populationBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(deltaT: CGFloat) {
        // Increase suspicion percentage by population ratio and stealth level
        let suspicionMod = CGFloat(self.player) - Player.stealth + Enemy.detection
        
        if suspicionMod > 0 && self.player != 0 {
            suspicion += suspicionMod * deltaT / 100
        } else if suspicion != 1 || self.enemy == 0 {
            suspicion -= City.suspicionDropRate * deltaT
        }
        
        suspicion.clamp(0, 1)
        
        // If war, kill percentage of each population
        if suspicion == 1 {
            currentEnemyKilled += Player.power * self.player * deltaT / 50
            currentPlayerKilled +=  Enemy.power * self.enemy * deltaT / 50
            
            if currentEnemyKilled >= 1 {
                let enemyKilled = currentEnemyKilled.rounded(.down).clamped(0, enemy)
                enemy -= enemyKilled
                currentEnemyKilled -= enemyKilled
            }
            
            if currentPlayerKilled >= 1 {
                let playerKilled = currentPlayerKilled.rounded(.down).clamped(0, player)
                player -= playerKilled
                currentPlayerKilled -= playerKilled
            }
            
            if !self.messageSent {
                messageSent = true
                sendMessage()
            }
        } else if enemy != 0 && player != 0 {
            // if NOT war, convert % of enemy to player
            currentConverted += self.player * Player.diplomacy * deltaT / 100
            
            //print(currentConverted, String(format: "%.3f", suspicion * 100))
            
            if currentConverted >= 1 {
                // Get num of converted people with max being the enemy population
                let convertNum = currentConverted.rounded(.down).clamped(0, enemy)
            
                enemy -= convertNum
                player += convertNum
                currentConverted -= convertNum
            }
        }
    }
    
    func handleRoadUnit(_ roadUnit: RoadUnit) {
        if roadUnit is PlayerUnit {
            self.player += CGFloat(roadUnit.count)
        } else if let message = roadUnit as? MessageUnit {
            self.suspicion = 1
            sendMessage(fromMessage: message)
        }
    }
    
    func sendTroops(count: Int, target: City) {
        let shortestPath = self.shortestPath(target: target)!

        let paths = shortestPath.path.map({(road: $0.road, source: $0.source,
                                            target: $0.source == $0.road.cityOne ? $0.road.cityTwo : $0.road.cityOne)})
        
        _ = PlayerUnit(paths: paths, totalDistance: shortestPath.distance, count: count, texture: nil)
        self.player -= CGFloat(count)
    }
    
    func sendMessage(fromMessage: MessageUnit? = nil) {
        for road in self.roads {
            let target = road.cityOne == self ? road.cityTwo : road.cityOne
            let helpLocation = fromMessage == nil ? self : fromMessage!.helpLocation
            
            if target.helpLocations.contains(helpLocation) {
                _ = MessageUnit(paths: [(road: road, source: self, target: target)],
                                totalDistance: road.distance, count: 0, texture: Resources.messengerIconTexture, helpLocation: helpLocation)
            }
        }
    }
    
    func shortestPath(target: City) -> (distance: CGFloat, path: [(road: Road, source: City)])? {
        var distanceCity: [City: (distance: CGFloat, path: [(road: Road, source: City)])] = [:]
        distanceCity[self] = (distance: 0, path: [])
        
        var visitedCities = Set<City>()
        
        var cities = PriorityQueue<(distance: CGFloat, city: City)>(sort: { $0.distance < $1.distance })
        cities.enqueue((distance: 0, city: self))
        
        repeat {
            let cityAndDistance = cities.dequeue()!
            
            // If current city is target city shortest path has been found
            if cityAndDistance.city == target {
                return distanceCity[target]!
            }
            
            visitedCities.insert(cityAndDistance.city)
            
            for road in cityAndDistance.city.roads {
                let roadCity = road.cityOne == cityAndDistance.city ? road.cityTwo : road.cityOne
                
                if let dCity = distanceCity[cityAndDistance.city] {
                    var distanceRoadCity = dCity.distance + road.distance
                    
                    if distanceCity[roadCity] == nil
                        || (distanceCity[roadCity] != nil && distanceRoadCity < distanceCity[roadCity]!.distance) {
                        
                        distanceCity[roadCity] = (distance: distanceRoadCity, path: dCity.path + [(road: road, source: cityAndDistance.city)])
                    }
                    
                    distanceRoadCity = distanceCity[roadCity]!.distance
                    
                    if !visitedCities.contains(roadCity) {
                        cities.enqueue((distance: distanceRoadCity, city: roadCity))
                    }
                }
                
            }
        } while (!cities.isEmpty)
        
        return nil
    }
}
