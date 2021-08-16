//
//  Collections.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index?) -> Iterator.Element? {
        guard let index = index else { return nil }
        return indices.contains(index) ? self[index] : nil
    }
    
    
    func dictionary<KeyType: Hashable, ValueType>(transform:(_ element: Iterator.Element) -> (key: KeyType, value: ValueType)) -> [KeyType : ValueType] {
        return reduce(into: [KeyType : ValueType]()) { (container, current) in
            let keyValue = transform(current)
            container[keyValue.key] = keyValue.value
        }
    }
}
