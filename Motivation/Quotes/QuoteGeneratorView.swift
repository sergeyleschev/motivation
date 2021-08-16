//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI
import Foundation
import SystemConfiguration
import AVFoundation

enum ActiveSheet: Identifiable {
    case shareSheetView
    
    var id: Int {
        hashValue
    }
}

struct QuoteGeneratorView: View {
    typealias GetQuoteHandler = () -> Void
    
    static let tag: String? = "Home"
    @Environment(\.managedObjectContext) var moc
    @State private var quote = Quote(id: "", quoteText: "Tap here", quoteAuthor: "Motivation", quoteGenre: "Fitness")
    @Binding var savedToDevice: Bool
    @State private var addedToClipboard = false
    @State private var rect1: CGRect = .zero
    @State private var uiImage: UIImage?
    @State private var viewState = CGSize.zero
    var favoriteQuotes: FetchedResults<QuoteCD>
    @State private var activeSheet: ActiveSheet?
    @EnvironmentObject var storage: Storage
    @State private var showBuying = false
    
    
    var body: some View {
        
        VStack {

            Color.clear.overlay(
                
                QuoteView(quote: quote)
                    .gesture(
                        LongPressGesture().onChanged { _ in
                            getQuote()
                        }
                    )
                    .animation(.spring())
                
            ).getRect($rect1).padding()
            .onAppear() {
                getQuote { trySave() }
            }
            .onChange(of: uiImage) { _ in self.uiImage = self.rect1.uiImage }
            .accessibility(addTraits: .isButton)
            .accessibility(label: Text("Change quote"))
            .accessibility(hint: Text("Changes quote when tapped, and display them"))
            
            HStack {
                
                Button(action: {
                    saveToDevice(quote: quote)
                }) {
                    Image(systemName: savedToDevice ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .imageScale(.large)
                        .foregroundColor(.red)
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Save"))
                .accessibility(hint: Text("Save the quote to your device, so you can access it later"))
                
                Button(action: {
                    self.uiImage = self.rect1.uiImage
                    if self.uiImage != nil {
                        activeSheet = .shareSheetView
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.red)
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Share quote"))
                .accessibility(hint: Text("opens a share sheet view"))
                
            }.disabled(quote.quoteText == "")
            
        }.sheet(item: $activeSheet) { item in
            switch item {
            case .shareSheetView:
                if uiImage != nil {
                    ShareSheetView(activityItems: [
                        self.uiImage!
                    ])
                }
            }
        }
        
    }
    
    
    private func getQuote(closure: GetQuoteHandler? = nil) {
        quote = Quote(id: "", quoteText: "", quoteAuthor: "", quoteGenre: "")
        
        getRandomQuote { quote in
            
            self.quote = quote
            savedToDevice = false
            addedToClipboard = false
        }
        
        closure?()
    }
    
    
    private func trySave() {
        XTimer.scheduledTimer(withTimeInterval: 2) {
            if storage.favoritesCount == 0 {
                saveToDevice(quote: quote)
            }
        }
    }
    

    func saveToDevice(quote: Quote) {
        savedToDevice.toggle()
        
        if savedToDevice == true {
            let favoriteQuote = QuoteCD(context: self.moc)
            favoriteQuote.id = quote.id
            favoriteQuote.quoteText = quote.quoteText
            favoriteQuote.quoteAuthor = quote.quoteAuthor
            favoriteQuote.quoteGenre = quote.quoteGenre
            
            storage.isFirstTap = false
            storage.favoritesCount = storage.favoritesCount + 1
            QuotesService.main.savePrimary(quoteCD: favoriteQuote)
            try? self.moc.save()
        } else {
            moc.undo()
        }
        
    }
    
}
