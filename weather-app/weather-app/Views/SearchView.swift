//
//  SearchView.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI
import Design

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("navigation_title_search")
                .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(
            text: $vm.query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "search_placeholder"
        )
        .tint(Color.themeColor)
        .searchBarTint()
    }
    
    var content: some View {
        List(vm.locations) { location in
            CellView(location: location.name, country: location.country)
                .listRowSeparator(.hidden)
            Divider()
        }
        .listStyle(.plain)
    }
}

#Preview {
    SearchView()
}
