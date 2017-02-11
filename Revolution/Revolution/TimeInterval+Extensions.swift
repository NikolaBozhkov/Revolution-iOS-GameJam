//
//  TimeInterval+Extensions.swift
//  Attraction
//
//  Created by Nikola Bozhkov on 1/31/17.
//  Copyright © 2017 Nikola Bozhkov. All rights reserved.
//

import Foundation

extension TimeInterval {
    public func clamped(_ v1: TimeInterval, _ v2: TimeInterval) -> TimeInterval {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
    
    @discardableResult
    public mutating func clamp(_ v1: TimeInterval, _ v2: TimeInterval) -> TimeInterval {
        self = clamped(v1, v2)
        return self
    }
}
