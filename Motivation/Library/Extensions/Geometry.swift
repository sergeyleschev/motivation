//
//  Geometry.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


extension GetRect {
    struct RectPreferenceKey: PreferenceKey {
        static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
            value = nextValue()
        }

        typealias Value = CGRect?

        static var defaultValue: CGRect?
    }
}



extension CGRect {
    var uiImage: UIImage? {
        UIApplication.shared.windows
            .filter { $0.isKeyWindow }
            .first?.rootViewController?.view
            .asImage(rect: self)
    }
}
