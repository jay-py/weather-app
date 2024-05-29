//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-29.
//

import SwiftUI

struct SearchBarTint: ViewModifier {

    init() {
        UISearchBar.appearance().setImage(searchBarImage(), for: .search, state: .normal)
    }

    private func searchBarImage() -> UIImage {
        let image = UIImage(systemName: "magnifyingglass")
        return image!.withTintColor(UIColor(Color.themeColor), renderingMode: .alwaysOriginal)
    }

    func body(content: Content) -> some View {
        content
    }

}

extension View {
    public func searchBarTint() -> some View {
        modifier(SearchBarTint())
    }
}
