//
//  Application.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


class Application : NSObject {
    static var main: Application = { Application() }()
    
    
    var cachesPath: String { return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] }
    
    let appleAppID = "1581317324"
    let supportAppName = "Fitness Motivation"
    let supportEmail = "sergey.leschev@gmail.com"
    

    override init() {
        super.init()
        
        ensureDirectoryExists(atPath: self.cachesPath)
    }
    
}
