//
//  ApiRepository.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

public actor ApiRepository {

    public init() {}

    public func getLocations(query: String) async throws -> Locations {
        return try await NetworkAgent.fetchData(
            path: .searchLocation(query: query),
            responseType: Locations.self
        )
    }
    
    public func getTemprature(lat: Double, lon: Double) async throws -> Temprature {
        return try await NetworkAgent.fetchData(
            path: .tempFor(lat: lat, lon: lon),
            responseType: Temprature.self
        )
    }
}
