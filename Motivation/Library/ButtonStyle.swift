//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI

struct ColoredButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
            .font(.title2)
        
    }
}
