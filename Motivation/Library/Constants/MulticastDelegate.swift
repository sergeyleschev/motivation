//
//  MulticastDelegate.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


open class MulticastDelegate<T> {
    private let delegates: NSHashTable<AnyObject>
    

    public init(strongReferences: Bool = false) {
        delegates = strongReferences ? NSHashTable<AnyObject>() : NSHashTable<AnyObject>.weakObjects()
    }
    

    public init(options: NSPointerFunctions.Options) {
        delegates = NSHashTable(options: options, capacity: 0)
    }
    

    public func addDelegate(_ delegate: T) {
        if containsDelegate(delegate) { return }
        delegates.add(delegate as AnyObject)
    }
    

    public func removeDelegate(_ delegate: T) { delegates.remove(delegate as AnyObject) }
    

    public func invokeDelegates(_ invocation: (T) -> ()) {
        for delegate in delegates.allObjects { invocation(delegate as! T) }
    }
    

    public func containsDelegate(_ delegate: T) -> Bool { delegates.contains(delegate as AnyObject) }
    
    public var isEmpty: Bool { delegates.count == 0 }

}


public func += <T>(left: MulticastDelegate<T>, right: T) { left.addDelegate(right) }


public func -= <T>(left: MulticastDelegate<T>, right: T) { left.removeDelegate(right) }


precedencegroup MulticastPrecedence {
    associativity: left
    higherThan: TernaryPrecedence
}


infix operator |> : MulticastPrecedence
public func |> <T>(left: MulticastDelegate<T>, right: (T) -> ()) { left.invokeDelegates(right) }

