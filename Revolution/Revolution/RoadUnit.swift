//
//  RoadUnit.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/11/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class RoadUnit: SKSpriteNode {
    
    var currentPathIndex = 0
    let paths: [(road: Road, source: City, target: City)]
    let totalDistance: CGFloat
    var count: Int
    var prevPosition: CGPoint = .zero
    
    var currentRoad: Road {
        return paths[currentPathIndex].road
    }
    
    var currentSource: City {
        return paths[currentPathIndex].source
    }
    
    var currentTarget: City {
        return paths[currentPathIndex].target
    }
    
    var currentRoadNormal: CGPoint {
        return (currentTarget.position - currentSource.position).normalized()
    }
    
    init(paths: [(road: Road, source: City, target: City)], totalDistance: CGFloat, count: Int, texture: SKTexture?) {
        self.paths = paths
        self.count = count
        self.totalDistance = totalDistance
        
        super.init(texture: texture, color: .red, size: texture == nil ? CGSize(width: 10, height: 10) : texture!.size())
        self.zPosition = 100
        addToRoad()
        
        self.position = currentSource.position
        self.prevPosition = currentSource.position
        
        self.currentRoad.parent!.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(deltaT: CGFloat) {
        // Move
        let moveP = currentRoadNormal * (deltaT * getSpeed())
        self.position += moveP
        
        if currentSource.position.distanceTo(self.position) >= currentRoad.distance {
            self.position = currentTarget.position
            
            // switch road
            removeFromRoad()
            moveNextRoad()
        }
        
        self.prevPosition = self.position
    }
    
    func getSpeed() -> CGFloat {
        return 0
    }
    
    func removeFromRoad() {}
    func addToRoad() {}
    
    func moveNextRoad() {
        removeFromRoad()
        currentPathIndex += 1
        
        if currentPathIndex == paths.count {
            // target reached
            self.paths[currentPathIndex - 1].target.handleRoadUnit(self)
            self.removeFromParent()
        } else {
            addToRoad()
        }
    }
    
    func remove() {
        removeFromRoad()
        removeFromParent()
    }
}
