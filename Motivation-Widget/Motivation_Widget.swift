//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import WidgetKit
import SwiftUI

struct MotivationEntry: TimelineEntry {
    let date: Date = Date()
    let quote: Quote
}

struct Provider: TimelineProvider {
    @AppStorage("primaryQuote", store: UserDefaults(suiteName: "group.com.siarhailiashchou.motivation")) var primaryQuoteData: Data = Data()
    
    func placeholder(in context: Context) -> MotivationEntry {
        let quote = Quote(id: "", quoteText: "Your favorite motivation can be displayed here", quoteAuthor: "Fitness", quoteGenre: "help")
        return MotivationEntry(quote: quote)
        
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MotivationEntry) -> Void) {
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: primaryQuoteData) else {
            print("Unable to decode primary quote")
           return
        }
        let entry = MotivationEntry(quote: quote)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: primaryQuoteData) else {
            print("Unable to decode primary quote")
           return
        }
        let entry = MotivationEntry(quote: quote)
        
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// MARK: View
struct MotivationWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    
    var body: some View {
        if family == .systemMedium {
            MediumWidget(entry: entry)
        } else {
            LargeWidget(entry: entry)
        }
    }
}

struct MediumWidget: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text("\(entry.quote.quoteText)")
                .font(Font.system(.title, design: .rounded).weight(.semibold))
                .padding(.horizontal)
                .allowsTightening(true)
                .layoutPriority(2)
                .minimumScaleFactor(0.3)
                .accessibilityLabel(Text("quote text is \(entry.quote.quoteText)"))

        }.padding()
        .multilineTextAlignment(.center)
        
    }
}

struct LargeWidget: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center) {

            HStack {
                Text("#")
                Text("\(entry.quote.quoteGenre)")
            }.padding(.bottom)
            .allowsTightening(true)
            .font(Font.system(.callout, design: .rounded).weight(.regular))
            .accessibilityLabel(Text("quote genre is hashtag \(entry.quote.quoteGenre)"))

            Text("\(entry.quote.quoteText)")
                .font(Font.system(.title, design: .rounded).weight(.semibold))
                .padding(.horizontal)
                .allowsTightening(true)
                .layoutPriority(2)
                .minimumScaleFactor(0.3)
                .accessibilityLabel(Text("quote text is \(entry.quote.quoteText)"))

            HStack {
                Text("~")
                Text("\(entry.quote.quoteAuthor)")

            }.padding(.top)
            .allowsTightening(true)
            .font(Font.system(.callout, design: .rounded).weight(.regular))
            .accessibilityLabel(Text("quote author is \(entry.quote.quoteAuthor)"))

        }.padding()
        .multilineTextAlignment(.center)
    }
}

@main
struct MotivationWidget: Widget {
    let kind: String = "Motivation_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MotivationWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Motivation")
        .description("These are the Widgets which display a motivation.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct MotivationWidge_Previews: PreviewProvider {
    static let quote = Quote(id: "", quoteText: "Your favorite motivation can be displayed here", quoteAuthor: "Fitness", quoteGenre: "help")
    static var previews: some View {
        MotivationWidgetEntryView(entry: MotivationEntry(quote: quote))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
