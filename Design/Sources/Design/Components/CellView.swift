//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-29.
//

import SwiftUI

public struct CellView: View {
    @Environment(\.colorScheme) private var colorScheme
    public let location: String
    public let country: String
    
    public init(location: String, country: String) {
        self.location = location
        self.country = country
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Text(location)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.fontColor(colorScheme == .light))
            Spacer()
            Text(country)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.fontColor(colorScheme == .light))
            Spacer()

        }
    }
}

#Preview {
    CellView(location: "London", country: "GB")
}
