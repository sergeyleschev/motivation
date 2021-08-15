//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI
import UIKit

struct SettingsRowView: View {
    let item: Item
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: item.image)
            }
            
            Text(item.title)
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(item: Item(image: "phone.fill", color: .systemGreen, title: "Phone", section: .legal, url: ""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        SettingsRowView(item: Item(image: "gear", color: .systemGray, title: "General", section: .legal, url: ""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}
