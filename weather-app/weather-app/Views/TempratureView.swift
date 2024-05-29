//
//  TempratureView.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI

struct TempratureView: View {
    @AppStorage("isLightMode") private var isLightMode: Bool = false
    @State private var isSheetPresented: Bool = false

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("navigation_title_temprature")
                .toolbar {
                    ToolbarItem {
                        toolBarButton
                    }
                }
        }
        .preferredColorScheme(isLightMode ? .light : .dark)
        .environment(\.colorScheme, isLightMode ? .light : .dark)
    }
    
    var content: some View {
        VStack {
            Spacer()
            Text("Hello, Temrature!")
                .frame(maxWidth: .infinity)
            Spacer()
        }
        .overlay {
            floatingButton
        }
        .sheet(isPresented: $isSheetPresented) {
            SearchView()
                .presentationDetents([.medium])
        }
    }
    
    var toolBarButton: some View {
        Button {
            withAnimation {
                isLightMode.toggle()
            }
        } label: {
            Image(systemName: isLightMode ? "moon.fill" : "sun.max.fill")
                .foregroundStyle(Color.themeColor)
                .rotationEffect(.degrees(isLightMode ? 0 : 180))
        }
    }
    
    var floatingButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isSheetPresented.toggle()
                }) {
                    Image(systemName: "location.magnifyingglass")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.themeColor)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color: .gray.opacity(0.6), radius: 10)
                        
                }
                .padding([.bottom, .trailing])
            }
        }
    }
    
    
    
    
}

#Preview {
    TempratureView()
}
