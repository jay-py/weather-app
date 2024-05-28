//
//  SplashView.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI
import Design

struct SplashView: View {
    @StateObject private var vm = SplashViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("splash_title")
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .font(.system(size: 50, weight: .bold, design: .default))
                .opacity(vm.isLoading ? 1 : 0)
                .scaleEffect(vm.isLoading ? 1.0 : 1.75)
                .animation(.easeInOut(duration: 1), value: vm.isLoading)
            Spacer()
        }
        .splashBackgroundColor()
        .task {
            await vm.fetchData()
        }

    }
}

#Preview {
    SplashView()
}
