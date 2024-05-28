//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI

extension Color {

    public static let themeColor = Color(#colorLiteral(red: 0.8463279605, green: 0.1055148169, blue: 0.1310607195, alpha: 1))

    public static func fontColor(_ ligthMode: Bool) -> Color {
        return ligthMode ? .black : .white
    }
}
