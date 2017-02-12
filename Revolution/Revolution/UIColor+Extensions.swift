//
//  SKColorExtension.swift
//  Attraction
//
//  Created by Nikola Bozhkov on 10/30/16.
//  Copyright © 2016 Nikola Bozhkov. All rights reserved.
//

import Foundation
import SpriteKit

extension UIColor {
    public var vectorFloat4: vector_float4 {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return vector_float4(Float(red), Float(green), Float(blue), Float(alpha))
    }
    
    convenience init(hex: String) {
        let redEnd = hex.index(hex.startIndex, offsetBy: 2)
        let red = hex.substring(with: hex.startIndex..<redEnd)
        let greenEnd = hex.index(redEnd, offsetBy: 2)
        let green = hex.substring(with: redEnd..<greenEnd)
        let blue = hex.substring(from: greenEnd)
        
        let redInt = UInt8(red, radix: 16)!
        let greenInt = UInt8(green, radix: 16)!
        let blueInt = UInt8(blue, radix: 16)!
        
        
        self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: 1.0)
    }
    
    public func saturate(withValue value: CGFloat) -> UIColor {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        saturation = saturation + value <= 1 ? saturation + value : 1
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    public func lighten(byPercent percent: CGFloat) -> SKColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Get min and max from colors
        let minVal = min(red, green, blue)
        let maxVal = max(red, green, blue)
        let delta = maxVal - minVal
        
        // Calculate luminance(lightness)
        var lum = (minVal + maxVal) / 2
        
        var sat: CGFloat = 0, hue: CGFloat = 0
        
        if delta > 0 {
            sat = delta / (1 - abs(2 * lum - 1))
            
            if maxVal == red {
                hue = (green - blue) / delta + (green < blue ? 6 : 0)
            } else if maxVal == green {
                hue = 2 + (blue - red) / delta
            } else if maxVal == blue {
                hue = 4 + (red - green) / delta
            }
        }
        
        lum = min(lum + percent, 1.0)
        
        // Convert back
        let c = (1 - abs(2 * lum - 1)) * sat
        let x = c * (1 - abs(hue.truncatingRemainder(dividingBy: 2.0) - 1))
        let m = lum - c / 2
        
        var rgb: (r: CGFloat, g: CGFloat, b: CGFloat)
        
        if hue < 1 {
            rgb = (c, x, 0)
        } else if hue < 2 {
            rgb = (x, c, 0)
        } else if hue < 3 {
            rgb = (0, c, x)
        } else if hue < 4 {
            rgb = (0, x, c)
        } else if hue < 5 {
            rgb = (x, 0, c)
        } else {
            rgb = (c, 0, x)
        }
        
        rgb = (rgb.r + m, rgb.g + m, rgb.b + m)
        
        return UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1.0)
    }
}
