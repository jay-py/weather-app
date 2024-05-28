//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

public actor LocationsRepository {

    public init() {}

    public func getLocations(name: String) async throws -> Locations {
        return try await NetworkAgent.fetchData(
            path: .search(name),
            responseType: Locations.self
        )
    }
}
