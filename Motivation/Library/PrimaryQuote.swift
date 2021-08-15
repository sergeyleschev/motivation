//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI
import WidgetKit

@available(iOS 14, *)
struct PrimaryQuote {
    @AppStorage("primaryQuote", store: UserDefaults(suiteName: "group.com.siarhailiashchou.motivation")) var primaryQuoteData: Data = Data()
    let primaryQuote: Quote
    
    func storeQuote() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(primaryQuote) else {
            print("Could not encode data")
            return
        }
        primaryQuoteData = data
        WidgetCenter.shared.reloadAllTimelines()
        print(String(decoding: primaryQuoteData, as: UTF8.self))
    }
}
