//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import Foundation
import SwiftUI
import CoreData
import UIKit

#if !APPCLIP
extension QuoteCD {
    var wrappedQuoteAuthor: String {
        return quoteAuthor ?? "Unknown Author"
    }

    var wrappedQuoteText: String {
        return quoteText ?? "Unknown Quote Text"
    }

    var wrappedQuoteGenre: String {
        return quoteGenre ?? "Unknown Quote Genre"
    }
}
#endif

extension GetRect {
    struct RectPreferenceKey: PreferenceKey {
        static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
            value = nextValue()
        }

        typealias Value = CGRect?

        static var defaultValue: CGRect?
    }
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
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

extension View {
    func getRect(_ rect: Binding<CGRect>) -> some View {
        self.modifier(GetRect(rect: rect))
    }
}

extension UIColor {

    static func colorWith(name: String) -> UIColor? {
        let selector = Selector("\(name)Color")
        if UIColor.self.responds(to: selector) {
            let color = UIColor.self.perform(selector).takeUnretainedValue()
            return (color as? UIColor)
        } else {
            return nil
        }
    }

}

extension Double {
    func toInt() -> Int {
        Int(self)
    }
}


