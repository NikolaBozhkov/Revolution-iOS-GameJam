//
//  Connection.swift
//  Revolution
//
//  Created by Nikola Bozhkov on 2/10/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import Foundation

class Connection {
    
    let destination: City
    let distance: Int
    
    init(destination: City, distance: Int) {
        self.destination = destination
        self.distance = distance
    }
}
