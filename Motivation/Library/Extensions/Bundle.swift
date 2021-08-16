//
//  Bundle.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


extension Bundle {
    var version: String { return infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown" }
    
    var buildNumberString: String { return infoDictionary?["CFBundleVersion"] as? String ?? "0" }
    var buildNumber: Int { return Int(buildNumberString) ?? 0 }
}
