//
//  SplashViewModel.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI

final class SplashViewModel: ObservableObject {

    @Published private(set) var isLoading: Bool = true
    let animationDuration = 1.0 //second

    internal var state: State = .idle {
        willSet {
            self.handleState(newValue == .error)
        }
    }

    // simulating some fetch that is needed to load the app
    // should be blocking main thread since the app state is dependent on the result
    @MainActor
    func fetchData() async {
        defer {
            self.isLoading = false
        }
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            self.state = .success
        } catch {
            self.state = .error
            print("\(TAG).fetchData() error: ", error)
        }
    }

    private func handleState(_ isError: Bool) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + animationDuration) {
            NotificationCenter.setAppState(to: isError ? .error : .home)
        }
    }

    private let TAG = "SplashViewModel"
    
    internal enum State {
        case success, error, idle
    }
}
