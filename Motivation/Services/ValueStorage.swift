//
//  ValueStorage.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation
import KeychainSwift


enum ValueStorageType {
    case icloud
    case keychain
    case defaults
    case cache
}


class ValueStorage {
    static var main: ValueStorage = { ValueStorage() }()
    
    
    private var iCloudStorage: NSUbiquitousKeyValueStore!
    private var keychainStorage: KeychainSwift!
    private var defaults: UserDefaults
    
    
    private var cacheBasePath: String { return Application.main.cachesPath / "valueStorage" }
    
    
    init() {
        iCloudStorage = NSUbiquitousKeyValueStore.default
        keychainStorage = KeychainSwift()
        defaults = UserDefaults.standard
        
        iCloudStorage.synchronize()
    }
    
    
    func integer(forKey key: String) -> Int? {
        guard let stringValue = string(forKey: key) else { return nil }
        return Int(stringValue)
    }
    
    
    func set(_ value: Int?, forKey key: String, inStorage: [ValueStorageType] = [.keychain]) {
        set(value != nil ? "\(value!)" : nil, forKey: key, inStorage: inStorage)
    }
    
    
    func double(forKey key: String) -> Double? {
        guard let stringValue = string(forKey: key) else { return nil }
        return Double(stringValue)
    }
    
    
    func set(_ value: Double?, forKey key: String, inStorage: [ValueStorageType] = [.keychain]) {
        set(value != nil ? "\(value!)" : nil, forKey: key, inStorage: inStorage)
    }
    
    
    func boolean(forKey key: String) -> Bool? {
        guard let stringValue = string(forKey: key) else { return nil }
        return stringValue == "1"
    }
    
    
    func set(_ value: Bool?, forKey key: String, inStorage: [ValueStorageType] = [.keychain]) {
        guard let value = value else { remove(key); return }
        set(value ? "1" : "0", forKey: key, inStorage: inStorage)
    }
    
    
    func date(forKey key: String) -> Date? {
        guard let stringValue = string(forKey: key) else { return nil }
        return ISO8601DateFormatter().date(from: stringValue)
    }
    
    
    func set(_ value: Date?, forKey key: String, inStorage: [ValueStorageType] = [.keychain]) {
        guard let value = value else { remove(key); return }
        set(ISO8601DateFormatter().string(from: value), forKey: key, inStorage: inStorage)
    }
    
    
    func string(forKey key: String) -> String? {
        if let value = keychainStorage.get(key) { return value }
        if let value = defaults.string(forKey: key) { return value }
        if let value = iCloudStorage.string(forKey: key) { return value }
        
        return try? String(contentsOfFile: cacheBasePath / key, encoding: .utf8)
    }
    
    
    func set(_ value: String?, forKey key: String, inStorage: [ValueStorageType] = [.keychain]) {
        remove(key)
        
        if let value = value {
            for storageType in inStorage {
                switch storageType {
                case .icloud: iCloudStorage.set(value, forKey: key); iCloudStorage.synchronize()
                case .keychain: keychainStorage.set(value, forKey: key)
                case .defaults: defaults.set(value, forKey: key); defaults.synchronize()
                case .cache:
                    ensureDirectoryExists(atPath: cacheBasePath)
                    try? value.write(toFile: cacheBasePath / key, atomically: true, encoding: .utf8)
                }
            }
        }
    }
    
    
    func remove(_ key: String) {
        iCloudStorage.removeObject(forKey: key)
        keychainStorage.delete(key)
        defaults.removeObject(forKey: key)
        
        iCloudStorage.synchronize()
        defaults.synchronize()
        
        try? FileManager.default.removeItem(atPath: cacheBasePath / key)
    }
    
    
    func isExists(_ key: String) -> Bool {
        if iCloudStorage.string(forKey: key) != nil { return true }
        if keychainStorage.get(key) != nil { return true }
        if defaults.string(forKey: key) != nil { return true }
     
        return FileManager.default.fileExists(atPath: cacheBasePath / key)
    }
}

