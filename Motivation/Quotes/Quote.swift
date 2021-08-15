//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import Foundation
 
// MARK: - Response
struct Response: Codable {
    let statusCode: Int
    let data: [Quote]
}

// MARK: - Quote
struct Quote: Codable, Hashable {
    var id, quoteText, quoteAuthor, quoteGenre: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quoteText, quoteAuthor, quoteGenre
    }
}

func getRandomQuote(completion: @escaping (Quote) -> Void) {
    
    let randomPage = Int.random(in: 1..<3)
//    var randomQuote = Int.random(in: 0..<36335)
    
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
            completion(quotes[randomQuote])
        }
        //print(String(data: data, encoding: .utf8)!)
    }.resume()
    
}
