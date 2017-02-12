//
//  MainScene.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

class MainScene: SKScene {
    
    var cities: [City]!
    let map = Map()
    var selectedCity: City?
    var troopCountLabel: SKLabelNode!
    var troopCountSelected: Int = 0 {
        didSet {
            troopCountLabel.text = String(troopCountSelected)
        }
    }
    
    var troopBtnSelected: SKNode?
    
    var isAddingPeople = true
    var lastTime = TimeInterval(0)
    
    var troopControl: SKNode!

    override func didMove(to view: SKView) {
        
        self.troopControl = self.childNode(withName: "troopControlWrap")!
        self.troopCountLabel = self.troopControl.childNode(withName: "troopCountLabel") as! SKLabelNode
    
        Player.initialize(powerLabel: childNode(withName: "powerLabel")! as! SKLabelNode,
                          diplomacyLabel: childNode(withName: "diplomacyLabel")! as! SKLabelNode,
                          speedLabel: childNode(withName: "speedLabel")! as! SKLabelNode,
                          stealthLabel: childNode(withName: "stealthLabel")! as! SKLabelNode)
        
        Enemy.initialize()
        self.addChild(self.map)
        
//        let fromRoad = self.map.tierTwoCities.first(where: { $0.direction == 1 })!.roads.first(where: { $0.cityOne.tier == 3 || $0.cityTwo.tier == 3 })!
//        let from = fromRoad.cityTwo.tier == 3 ? fromRoad.cityTwo : fromRoad.cityOne
//        print(from.direction)
//        
//        //let toRoad = self.map.tierTwoCities.first(where: { $0.direction == 2 })!.roads.first(where: { $0.cityOne.tier == 3 || $0.cityTwo.tier == 3 })!
////        let toRoad = self.map.tierTwoCities.first(where: { $0.direction == 2 })!.roads.first(where: { $0.cityOne.tier == 3 || $0.cityTwo.tier == 3 })!
//        //let to = toRoad.cityTwo.tier == 3 ? toRoad.cityTwo : toRoad.cityOne
//        let to = self.map.tierTwoCities.first(where: { $0.direction == 3 })!
//        //let to = self.map.mainCity
//        let path = from.shortestPath(target: to)!
//        
//        print(to.direction)
//        print(path.distance)
//        for road in path.path {
//            let target = road.source == road.road.cityOne ? road.road.cityTwo : road.road.cityOne
//            print(String(road.source.direction) + " - " + String(road.source.tier), String(target.direction) + " - " + String(target.tier))
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.nodes(at: location).first
        let city = self.nodes(at: location).first(where: { $0 is City }) as? City
        
        // Before game started
        if self.isAddingPeople {
            if let city = city, city.tier == 3 {
                city.player += 1
                Player.initialPeople -= 1
                let revLeftLabel = childNode(withName: "revLeftLabel") as! SKLabelNode
                revLeftLabel.text = String(Player.initialPeople) + " left"
                
                if Player.initialPeople == 0 {
                    childNode(withName: "chooseRevLabel")?.removeFromParent()
                    revLeftLabel.removeFromParent()
                    
                    // Add rev began label
                    let revBegunLabel = childNode(withName: "revBegunLabel") as! SKLabelNode
                    revBegunLabel.isHidden = false
                    revBegunLabel.run(SKAction.sequence([SKAction(named: "RevBegunAction")!, SKAction.removeFromParent()]))
                    
                    self.isAddingPeople = false
                }
            }
        } else if let node = node {
            // If skill level up
            if node.name == "power" {
                Player.power.add(1)
            } else if node.name == "diplomacy" {
                Player.diplomacy.add(1)
            } else if node.name == "speed" {
                Player.speed.add(1)
            } else if node.name == "stealth" {
                Player.stealth.add(1)
            }
            
            // If selecting city
            if let city = city {
                // If targeting other city
                if self.selectedCity != nil && self.selectedCity != city {
                    print("enter1")
                    self.troopCountSelected = CGFloat(self.troopCountSelected) > selectedCity!.player ? Int(selectedCity!.player) : self.troopCountSelected
                    
                    if self.troopCountSelected > 0 {
                        self.selectedCity!.sendTroops(count: self.troopCountSelected, target: city)
                    }
                }
                
                // Select / deselect
                if self.selectedCity != nil {
                    print("enter2")
                    self.selectedCity = nil
                    self.troopCountSelected = 0
                    self.troopControl.run(Resources.troopCtrlHideAction)
                } else {
                    print("enter3")
                    self.selectedCity = city
                    self.troopControl.run(Resources.troopCtrlShowAction)
                }
            }
            
            if node.parent!.name == "troopControl" && node.name != "troopControlBg" {
                print("enter4")
                self.troopBtnSelected = node
                self.troopBtnSelected?.isHidden = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.nodes(at: location).first
        
        if let node = node, node.parent!.name == "troopControl" && node.name != "troopControlBg" {
            self.troopBtnSelected?.isHidden = false
            self.troopBtnSelected = node
            self.troopBtnSelected?.isHidden = true
        } else if node == nil || node?.parent!.name != "troopControl" {
            self.troopBtnSelected?.isHidden = false
            self.troopBtnSelected = nil
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.nodes(at: location).first

        // Check for troop addition
        if let node = node, node.parent!.name == "troopControl", self.troopBtnSelected != nil {
            
            // Reshow button
            self.troopBtnSelected?.isHidden = false
            
            
            if self.troopBtnSelected!.name == "troopControlP1" {
                self.troopCountSelected += 1
            } else if self.troopBtnSelected!.name == "troopControlP2" {
                self.troopCountSelected += 2
            } else if self.troopBtnSelected!.name == "troopControlP5" {
                self.troopCountSelected += 5
            } else if self.troopBtnSelected!.name == "troopControlP10" {
                self.troopCountSelected += 10
            }
            
            if let selectedCity = self.selectedCity {
                self.troopCountSelected = CGFloat(self.troopCountSelected) > selectedCity.player ? Int(selectedCity.player) : self.troopCountSelected
            }
            
            self.troopBtnSelected = nil
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaT = self.lastTime == 0.0 ? 0.0 : currentTime - self.lastTime
        
        if !self.isAddingPeople {
            self.map.update(deltaT: CGFloat(deltaT))
        }
        
        self.lastTime = currentTime
    }
}
