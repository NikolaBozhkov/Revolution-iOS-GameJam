//
//  PopulationBar.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/11/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class PopulationBar: SKNode {

    var enemyLabel: PopulationLabel
    var playerLabel: PopulationLabel
    
    init(position: CGPoint, enemyPopulation: Int, playerPopulation: Int) {                
        self.enemyLabel = PopulationLabel(horizontalAlignmentMode: .right, position: position, isEnemy: true)
        self.playerLabel = PopulationLabel(horizontalAlignmentMode: .left, position: position, isEnemy: false)
        
        super.init()

        self.position = position
        self.addChild(self.enemyLabel)
        self.addChild(self.playerLabel)
        self.zPosition = 100
        
        setPopulation(label: self.enemyLabel, value: enemyPopulation, oldValue: enemyPopulation, animate: false)
        setPopulation(label: self.playerLabel, value: playerPopulation, oldValue: playerPopulation, animate: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPercent(_ percent: CGFloat, bar: SKSpriteNode) {
        bar.xScale = percent
    }
    
    func setPopulation(label: PopulationLabel, value: Int, oldValue: Int, animate: Bool) {
        label.countLabel.text = String(value)
        
        if animate {
            let delta = value - oldValue
            
            if delta != 0 {
                let deltaLabel = PopulationLabel(label)
                deltaLabel.countLabel.text = (delta > 0 ? "+" : "") + String(delta)
                
                deltaLabel.position += CGPoint(x: 0, y: 10)
                deltaLabel.alpha = 0.7
                deltaLabel.run(SKAction.sequence([SKAction(named: "DeltaPopulationAction")!,
                                                  SKAction.removeFromParent()]))
                
                self.addChild(deltaLabel)
            }
        }
    }
    
    func setEnemyPopulation(enemy: Int, oldEnemy: Int, animate: Bool = true) {
        self.setPopulation(label: self.enemyLabel, value: enemy, oldValue: oldEnemy, animate: animate)
    }
    
    func setPlayerPopulation(player: Int, oldPlayer: Int, animate: Bool = true) {
        self.setPopulation(label: self.playerLabel, value: player, oldValue: oldPlayer, animate: animate)
    }
}
