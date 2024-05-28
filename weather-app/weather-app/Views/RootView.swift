//
//  ContentView.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var vm = RootViewModel()
    
    var body: some View {
        switch vm.state {
        case .splash:
            SplashView()
        case .home:
            Color.red
        case .error:
            Text("error")
        }
    }
}

#Preview {
    RootView()
}
