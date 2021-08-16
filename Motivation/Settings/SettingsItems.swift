//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import Foundation

struct Items {
    private let data: [Item] = [
        
        Item(image: "star.fill",
             color: .systemYellow,
             title: "Rate The App",
             section: .feedback,
             url: "https://apps.apple.com/us/app/fitness-motivation/id1581317324?itsct=apps_box_link&itscg=30200"),
        /*
        Item(image: "megaphone.fill",
             color: .systemOrange,
             title: "Feedback",
             section: .feedback,
             url: "http://motivations.coach/fitness-motivation/feedback"),
 */

        Item(image: "lock.shield.fill",
             color: .systemGreen,
             title: "Privacy",
             section: .legal,
             url: "https://motivations.coach/privacy.html"),
        
        /*
        Item(image: "globe",
            color: .systemGray,
            title: "Instagram",
            section: .miscellaneous,
            url: "https://instagram.com/sergeyleschev"),
        
        Item(image: "plus.app.fill",
             color: .systemGreen,
             title: "More Apps",
             section: .miscellaneous,
             url: "https://apps.apple.com/us/developer/siarhai-liashchou/")
 */
        
    ]
    
    let miscellaneous: [Item]
    let legal: [Item]
    let feedback: [Item]
    
    init() {
        miscellaneous = data.filter { $0.section == .miscellaneous }
        legal = data.filter { $0.section == .legal }
        feedback = data.filter { $0.section == .feedback }

    }
}

enum ListSection: CaseIterable {
    case miscellaneous
    case legal
    case feedback
}

struct Item: Identifiable, Hashable {
    
    // MARK: - Types
    enum Color: String, CaseIterable {
        case systemOrange
        case systemBlue
        case systemGreen
        case systemRed
        case systemPurple
        case systemGray
        case cyan
        case systemYellow
        case black
    }
    
    // MARK: - Properties
    var id = UUID()
    let image: String
    let color: Color
    let title: String
    let section: ListSection
    let url: String
}
