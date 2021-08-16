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


