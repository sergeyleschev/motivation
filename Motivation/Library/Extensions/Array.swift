//
//  Array.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


extension Array {
    @discardableResult mutating func popFirst() -> Element? {
        if isEmpty { return nil }
        return removeFirst()
    }
}


extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}


extension Array where Element : Hashable {
    var unorderedUnique: [Element] {
        return Array(Set(self))
    }
}


extension MutableCollection {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}


extension Sequence {
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

