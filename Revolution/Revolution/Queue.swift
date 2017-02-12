//
//  Queue.swift
//  Attraction
//
//  Created by Nikola Bozhkov on 11/21/16.
//  Copyright © 2016 Nikola Bozhkov. All rights reserved.
//

import Foundation

public class Queue<T> {
    private var first: QNode<T>?
    private var last: QNode<T>?
    
    public var isEmpty: Bool {
        return first == nil
    }
    
    public func enQueue(_ value: T) {
        let newNode = QNode<T>(value: value)
        
        if first == nil {
            first = newNode
            last = first
            return
        }
        
        last?.next = newNode
        last = newNode
        
    }
    
    public func deQueue() -> T? {
        let value = first?.value
        first = first?.next
        return value
    }
}
