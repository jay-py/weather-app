//
//  ColorExtension.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI

extension Color {

    public static let themeColor = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))

    public static func fontColor(_ ligthMode: Bool) -> Color {
        return ligthMode ? .black : .white
    }
}
