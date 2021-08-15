//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI

struct QuoteView: View {

    var quote: Quote

    var body: some View {

        #if os(iOS)
            VStack(alignment: .center) {

                HStack {
                    Text("#")
                    Text("\(quote.quoteGenre)")
                }.padding(.bottom)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .rounded).weight(.regular))
                .accessibility(value: Text("quote genre is hashtag \(quote.quoteGenre)"))

                Text("\(quote.quoteText)")
                    .font(Font.system(.title, design: .rounded).weight(.semibold))
                    .padding(.horizontal)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.3)
                    .accessibility(value: Text("quote text is \(quote.quoteText)"))

                HStack {
                    Text("~")
                    Text("\(quote.quoteAuthor)")

                }.padding(.top)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .rounded).weight(.regular))
                .accessibility(value: Text("quote author is \(quote.quoteAuthor)"))

            }.foregroundColor(Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)))
            .multilineTextAlignment(.center)
            .padding()
            .background(Color(#colorLiteral(red: 0.2494066656, green: 0.3547991216, blue: 0.4223732948, alpha: 1)).clipShape(RoundedRectangle(cornerRadius: 25)))
        #elseif os(watchOS)
        VStack(alignment: .leading) {

                Text("\(quote.quoteText)")
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.1)
                    .accessibility(value: Text("quote text is \(quote.quoteText)"))
                HStack {
                    Text("~")
                    Text("\(quote.quoteAuthor)")

                }.padding(.top, 1)
                .allowsTightening(true)
                .font(.body)
                .padding()
                .accessibility(value: Text("quote author is \(quote.quoteAuthor)"))

        }.multilineTextAlignment(.leading)
        .edgesIgnoringSafeArea(.all)
        #endif
        
    }
}
