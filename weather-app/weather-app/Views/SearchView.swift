//
//  SearchView.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI
import Design
import Domain

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    @Binding var isPresented: Bool
    @Binding var result: Temprature?
    
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
        .onReceive(vm.$temprature, perform: { value in
            if let value {
                self.result = value
                self.isPresented.toggle()
            }
        })
    }
    
    var content: some View {
        List(vm.locations) { location in
            Button(action: {
                vm.getTemprature(location: location)
            }, label: {
                CellView(location: location.name, country: location.country)
            })
            .listRowSeparator(.hidden)
            Divider()
        }
        .listStyle(.plain)
    }
}

#Preview {
    SearchView(isPresented: .constant(true), result: .constant(nil))
}
