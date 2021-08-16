//
//  Common.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


func ensureDirectoryExists(atPath: String) {
    do { try FileManager.default.createDirectory(atPath: atPath, withIntermediateDirectories: true, attributes: nil) } catch {}
}


func postNotification(_ name: Foundation.Notification.Name) {
    NotificationCenter.default.post(name: name, object: nil)
}


func observeNotification(_ name: Foundation.Notification.Name, object: Any, selector: Selector) {
    NotificationCenter.default.addObserver(object, selector: selector, name: name, object: nil)
}
