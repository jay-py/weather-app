//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

extension Notification {
    public static let setAppState = Notification.Name.init(rawValue: "setAppState")

}
extension NotificationCenter {
    public static func setAppState(to state: AppState) {
        NotificationCenter.default.post(
            name: Notification.setAppState, object: nil,
            userInfo: [AppState.key: state.rawValue])
    }
}
