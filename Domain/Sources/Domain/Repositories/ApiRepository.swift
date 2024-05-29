//
//  ApiRepository.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

public actor ApiRepository {

    public init() {}

    public func getLocations(name: String) async throws -> Locations {
        return try await NetworkAgent.fetchData(
            path: .search(name),
            responseType: Locations.self
        )
    }
    
    public func getTemprature(lat: Double, lon: Double) async throws -> Temprature {
        return try await NetworkAgent.fetchData(
            path: .temp(lat: lat, lon: lon),
            responseType: Temprature.self
        )
    }
}
