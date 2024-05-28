//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

public actor TempratureRepository {

    public init() {}

    public func getTemprature(lat: Double, lon: Double) async throws -> Temprature {
        return try await NetworkAgent.fetchData(
            path: .temp(lat: lat, lon: lon),
            responseType: Temprature.self
        )
    }
}
