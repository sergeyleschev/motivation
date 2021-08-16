//
//  Numbers.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation
import UIKit


extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
    
    init(_ value: Bool) {
        self = value ? 1 : 0
    }
    
    
    static func random(min: Int, max: Int) -> Int {
        return Int(round(Double.random(min: Double(min), max: Double(max))))
    }
    
    
    var withCommas: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}


extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }

    var isInt: Bool { floor(self) == self }
}


extension Double {
    var nanZero: Double {
        if self.isNaN { return 0 }
        if self.isInfinite { return 0 }
        
        return self
    }
    
    
    var isInt: Bool { floor(self) == self }
    
    
    func toInt() -> Int { Int(self) }
    
    
    var divideSafe: Double {
        if self == 0 { return 1 }
        return self
    }
    
    
    func stringRoundTo(nearest: Double, zeroless: Bool = true) -> String {
        let rounded = roundTo(nearest: nearest)
        var string = "\(rounded)"
        
        if zeroless {
            string = string.replacingOccurrences(of: ".0", with: "")
        }
        
        if string.isEmpty {
            string = "0"
        }
        
        return string
    }
    
    
    func stringRoundTo(places: Int = 1, zeroless: Bool = true) -> String {
        let rounded = roundTo(places: places)
        var string = "\(rounded)"
        
        if zeroless {
            string = string.replacingOccurrences(of: ".0", with: "")
        }
        
        if string.isEmpty {
            string = "0"
        }
        
        return string
    }
    
    
    func floorTo(places: Int) -> Double {
        let divisor = pow(10, Double(places))
        return floor((self * divisor)) / divisor
    }
    
    
    func ceilTo(places: Int) -> Double {
        let divisor = pow(10, Double(places))
        return ceil((self * divisor)) / divisor
    }
    
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    
    static func random(min: Double = 0.0, max: Double = 1.0) -> Double {
        return min + (max - min) * Double(arc4random()) / Double(UInt32.max)
    }
    
    
    func floorTo(nearest: Double) -> Double {
        let n = 1 / nearest
        let numberToRound = self * n
        return floor(numberToRound) / n
    }
    
    
    func ceilTo(nearest: Double) -> Double {
        let n = 1 / nearest
        let numberToRound = self * n
        return ceil(numberToRound) / n
    }
    
    
    func roundTo(nearest: Double) -> Double {
        let n = 1 / nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
    
    
    func localizedPrice() -> String {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.numberStyle = .currency
        formatter.currencyCode = locale.currencyCode ?? "USD"
        formatter.maximumFractionDigits = 2

        let number = NSNumber(value: self)
        return formatter.string(from: number)!
    }
    
}


extension CGFloat {
    static func random(min: CGFloat = 0.0, max: CGFloat = 1.0) -> CGFloat {
        return CGFloat(Double.random(min: Double(min), max: Double(max)))
    }
}


extension ClosedRange {
    func clamp(value : Bound) -> Bound {
        return self.lowerBound > value ? self.lowerBound
            : self.upperBound < value ? self.upperBound
            : value
    }
}


extension CountableRange {
    func clamp(value : Bound) -> Bound {
        return self.lowerBound > value ? self.lowerBound
            : self.upperBound < value ? self.upperBound
            : value
    }
}


func <(lhs: Bool, rhs: Bool) -> Bool { return Int(lhs) < Int(rhs) }
func <=(lhs: Bool, rhs: Bool) -> Bool { return Int(lhs) <= Int(rhs) }
func >(lhs: Bool, rhs: Bool) -> Bool { return Int(lhs) > Int(rhs) }
func >=(lhs: Bool, rhs: Bool) -> Bool { return Int(lhs) >= Int(rhs) }
