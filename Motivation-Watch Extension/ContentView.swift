//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI

struct ContentView: View {
    @State private var quote = Quote(id: "", quoteText: "Tap here", quoteAuthor: "Motivation", quoteGenre: "Fitness")
    @State var viewState = CGSize.zero
    
    var body: some View {
        QuoteView(quote: quote)
            .gesture(
                LongPressGesture().onChanged { _ in
                    getQuote()
                }
            ).animation(.spring())
            .onAppear() { getQuote() }
            .padding()
    }
    
    
    func getQuote() {
        getRandomQuote { quote in
            self.quote = quote
        }
    }
    
    
    func getRandomQuote(completion: @escaping (Quote) -> Void) {
        
        let randomPage = Int.random(in: 1..<2)
//        let randomQuote = Int.random(in: 0..<36335)
        
        let url = Bundle.main.url(forResource: "quotes\(randomPage).json", withExtension: nil)
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
