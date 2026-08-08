//
//  AppleSpringButtonStyle.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

// Style d'animation interactif signature Apple : Micro-rebond élastique au toucher
struct AppleSpringButtonStyle: ButtonStyle {
    var scale: CGFloat = 0.96
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1.0)
            .opacity(configuration.isPressed ? 0.92 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == AppleSpringButtonStyle {
    static var appleSpring: AppleSpringButtonStyle {
        AppleSpringButtonStyle()
    }
    
    static func appleSpring(scale: CGFloat) -> AppleSpringButtonStyle {
        AppleSpringButtonStyle(scale: scale)
    }
}
