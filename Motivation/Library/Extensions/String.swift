//
//  String.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


extension String {
    
    func writeTo(filepath: String) { try? write(toFile: filepath, atomically: true, encoding: .utf8) }
    
    
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    
    
    func index(from: Int) -> Index { self.index(startIndex, offsetBy: from) }
    func stringAt(_ i: Int) -> String { i <= self.count ? String(Array(self)[i]) : "" }
    func charAt(_ i: Int) -> Character { i <= self.count ? Array(self)[i] : Character("") }

    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get { self[..<index(startIndex, offsetBy: value.upperBound)] }
    }
    
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get { self[...index(startIndex, offsetBy: value.upperBound)] }
    }
    
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get { self[index(startIndex, offsetBy: value.lowerBound)...] }
    }
}


func / (left: String, right: String) -> String { (left as NSString).appendingPathComponent(right) }

