//
//  QNode.swift
//  Attraction
//
//  Created by Nikola Bozhkov on 11/21/16.
//  Copyright © 2016 Nikola Bozhkov. All rights reserved.
//

import Foundation

public class QNode<T> {
    public var value: T
    public var next: QNode<T>?
    
    init(value: T) {
        self.value = value
    }
}
