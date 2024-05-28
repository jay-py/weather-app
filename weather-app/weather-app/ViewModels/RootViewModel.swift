//
//  RootViewModel.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI
import Domain


final class RootViewModel: ObservableObject {

    @Published private(set) var state = AppState.splash

    init() {
        NotificationCenter.default.addObserver(
            forName: Notification.setAppState,
            object: nil,
            queue: .main,
            using: stateHandler(_:))
    }

    private func setAppState(to state: AppState) {
        DispatchQueue.main.async {
            withAnimation {
                self.state = state
            }
        }
    }
    
    private func stateHandler(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let statekey = userInfo[AppState.key] as? String,
            let state = AppState(rawValue: statekey)
        {
            self.setAppState(to: state)
        }
    }

}

