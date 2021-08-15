//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI
import WidgetKit
import CoreData
import Foundation
import StoreKit
import AVFoundation

struct QuoteDetailView: View {
    
    var favoriteQuote: QuoteCD
    
    @State private var addedToClipboard = false
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage?

    
    var body: some View {
        
        VStack {
            
            Color.clear.overlay(
                
                QuoteView(quote: convert(quoteCD: favoriteQuote))
                    .padding()
                
            ).getRect($rect1)
            .onChange(of: uiimage) {_ in self.uiimage = self.rect1.uiImage }
            
            HStack {
                
                Button(action: {
                    savePrimary(quoteCD: favoriteQuote)
                }) {
                    Image(systemName: addedToFavorites ? "checkmark.circle.fill" : "checkmark.circle")
                        .imageScale(.large)
                        .foregroundColor(.red)
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Display on a widget"))
                .accessibility(hint: Text("Display the quote on a widget"))
                
                Button(action: {
                    self.uiimage = self.rect1.uiImage
                    if self.uiimage != nil {
                        showingShareSheetView = true
                    }
                    
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.red)
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Share quote"))
                .accessibility(hint: Text("opens a share sheet view"))
                
            }
            
        }.sheet(isPresented: $showingShareSheetView) {
            if uiimage != nil {
                ShareSheetView(activityItems: [
                    self.uiimage!
                ])
            }
        }
        
    }
    
    
    func savePrimary(quoteCD: QuoteCD) {
        
        let quote = Quote(id: quoteCD.id ?? "", quoteText: quoteCD.wrappedQuoteText, quoteAuthor: quoteCD.wrappedQuoteAuthor, quoteGenre: quoteCD.wrappedQuoteGenre)
        
        if #available(iOS 14, *) {
            let newPrimary = PrimaryQuote(primaryQuote: quote)
            newPrimary.storeQuote()
            
        }
        
        addedToFavorites = true
    }
    
    func convert(quoteCD: QuoteCD) -> Quote {
        let quote = Quote(id: quoteCD.id ?? "", quoteText: quoteCD.wrappedQuoteText, quoteAuthor: quoteCD.wrappedQuoteAuthor, quoteGenre: quoteCD.wrappedQuoteGenre)
        return quote
    }
}
