//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation
import OSLog

struct AppEnvironment {

    enum Environments {
        case debug, beta, prod
    }

    private static let isBeta =
        Bundle.main.bundleIdentifier?.lowercased()
        .contains("beta") ?? false
    private static let isDebug =
        Bundle.main.bundleIdentifier?.lowercased()
        .contains("debug") ?? false

    static var current: Environments {
        if isDebug {
            return .debug
        } else if isBeta {
            return .beta
        } else {
            return .prod
        }
    }
}

// MARK: - print() override
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    let output = items.map { "\($0)" }.joined(separator: separator)
    if AppEnvironment.current == .debug {
        Swift.print(output, terminator: terminator)
    } else {
        Logger().info("\(output)")
    }
}
