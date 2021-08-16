//
//  Storage.swift
//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import Foundation

class Storage: ObservableObject {
    var amount: Int = 10000
    
    var favoritesCount: Int {
        get { ValueStorage.main.integer(forKey: "favoritesCount") ?? 0 }
        set { ValueStorage.main.set(newValue, forKey: "favoritesCount", inStorage: [.defaults]) }
    }
    
    var isFirstTap: Bool {
        get { ValueStorage.main.boolean(forKey: "isFirstTap") ?? false }
        set { ValueStorage.main.set(newValue, forKey: "isFirstTap", inStorage: [.defaults]) }
    }
}

