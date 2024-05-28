//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI

struct SplashBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [.themeColor, .themeColor.opacity(0.4)], startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(.all)
            )
    }
}

extension View {
    public func splashBackgroundColor() -> some View {
        modifier(SplashBackgroundColor())
    }
}
