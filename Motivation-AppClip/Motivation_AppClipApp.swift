//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI
import AVFoundation

@main
struct MotivationAppClipApp: App {
    @State private var showingShareSheetView = false
    let synthesizer =  AVSpeechSynthesizer()
    var body: some Scene {
        WindowGroup {
            ContentView(showingShareSheetView: $showingShareSheetView).onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                guard let incomingURL = userActivity.webpageURL,
                      let _ = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true)
                else {
                    return
                }
            }
        }
    }
    
    func handleUserActivity(_ userActivity: NSUserActivity) {
        guard let incomingURL = userActivity.webpageURL,
        let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
        let _ = components.queryItems else {
            return
        }
    }
}
