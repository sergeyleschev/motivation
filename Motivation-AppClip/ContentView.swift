//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var quote = Quote(id: "", quoteText: "Tap here", quoteAuthor: "Motivation", quoteGenre: "Fitness")
    @Binding var showingShareSheetView: Bool
    @State private var addedToClipboard = false
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage?
    @State var viewState = CGSize.zero

    
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
                    .padding()
                
            ).getRect($rect1)
            .onChange(of: uiimage) {_ in self.uiimage = self.rect1.uiImage }
            .onAppear() { getQuote() }
            .accessibility(addTraits: .isButton)
            .accessibility(label: Text("Change quote"))
            .accessibility(hint: Text("Changes quote when tapped, and display them"))
            
            HStack {
                
                Button(action: {
                    self.uiimage = self.rect1.uiImage
                    if self.uiimage != nil {
                        showingShareSheetView = true
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Share quote"))
                .accessibility(hint: Text("opens a share sheet view"))
                
                
            }.disabled(quote.quoteText == "")
            
        }
        .sheet(isPresented: $showingShareSheetView) {
            if uiimage != nil {
                ShareSheetView(activityItems: [
                    self.uiimage!
                ])
            }
        }
    }
    
    
    private func getQuote() {
        quote = Quote(id: "", quoteText: "", quoteAuthor: "", quoteGenre: "")
        
        getRandomQuotes { quote in
            
            self.quote = quote
            addedToClipboard = false
        }
    }
    
    
    func getRandomQuotes(completion: @escaping (Quote) -> Void) {
        
        let randomQuote = Int.random(in: 0..<49)
        
        let url = Bundle.main.url(forResource: "sampleQuotes.json", withExtension: nil)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                print(String(describing: error))
                return
            }
            
            let quotes = response.data.filter({ $0.quoteGenre == "motivational" || $0.quoteGenre == "fitness" })
            
            let randomQuote = Int.random(in: 0..<quotes.count)
            
            DispatchQueue.main.async {
                completion(response.data[randomQuote])
            }
            //print(String(data: data, encoding: .utf8)!)
        }.resume()
        
    }
    
}
