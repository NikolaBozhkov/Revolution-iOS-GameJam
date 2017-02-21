//
//  Resources.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/12/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import SpriteKit

struct Resources {
    
    static let troopCtrlShowAction = SKAction(named: "TroopCtrlShowAction")!
    static let troopCtrlHideAction = SKAction(named: "TroopCtrlHideAction")!
    static let troopCtrlBtnAction = SKAction(named: "TroopCtrlBtnAction")!
    
    static let messengerIconTexture = SKTexture(imageNamed: "messengerIcon")
    static let playerTexture = SKTexture(imageNamed: "Revolutioner")
    static let suspicionBarBgTexture = SKTexture(imageNamed: "SuspicionBarBackground")
    static let suspicionBarLeftTexture = SKTexture(imageNamed: "SBarLR")
    static let suspicionBarMidTexture = SKTexture(imageNamed: "SBarMid")
    static let suspicionBarIconTexture = SKTexture(imageNamed: "SBarIcon")
    
    static let suspicionEmitter = SKEmitterNode(fileNamed: "SuspicionEmitter.sks")!
}
