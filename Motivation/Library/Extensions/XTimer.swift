//
//  XTimer.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


class XTimer {
    typealias BlockHandler = () -> Swift.Void
    
    
    fileprivate var internalTimer: Timer!
    fileprivate var blockHandler: BlockHandler!
    
    
    @objc fileprivate func onInternalTimer() { blockHandler?() }
    
    
    func invalidate() { internalTimer?.invalidate() }
    
    
    @discardableResult class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool = false, block: @escaping BlockHandler) -> XTimer {
        let timer = XTimer()
        
        timer.blockHandler = block
        timer.internalTimer = Timer.scheduledTimer(timeInterval: interval, target: timer, selector: #selector(onInternalTimer), userInfo: nil, repeats: repeats)
        
        return timer
    }
}

