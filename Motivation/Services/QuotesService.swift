//
//  QuotesService.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


class QuotesService {
    typealias SavePrimaryHandler = () -> Void
    
    static var main: QuotesService = { QuotesService() }()
    
    
    
    func savePrimary(quoteCD: QuoteCD, closure: SavePrimaryHandler? = nil) {
        let quote = Quote(id: quoteCD.id ?? "", quoteText: quoteCD.wrappedQuoteText, quoteAuthor: quoteCD.wrappedQuoteAuthor, quoteGenre: quoteCD.wrappedQuoteGenre)
        
        if #available(iOS 14, *) {
            let newPrimary = PrimaryQuote(primaryQuote: quote)
            newPrimary.storeQuote()
            
        }
        
        closure?()
    }
    
    func convert(quoteCD: QuoteCD) -> Quote {
        let quote = Quote(id: quoteCD.id ?? "", quoteText: quoteCD.wrappedQuoteText, quoteAuthor: quoteCD.wrappedQuoteAuthor, quoteGenre: quoteCD.wrappedQuoteGenre)
        return quote
    }


}
