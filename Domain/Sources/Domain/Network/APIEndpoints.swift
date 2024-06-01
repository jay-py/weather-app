//
//  APIEndpoints.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

enum APIEndpoints {
    case searchLocation(query: String)
    case tempFor(lat:Double, lon: Double)

    var value: String {
        switch self {
            case .searchLocation(let query):
                return "https://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=5&appid=4754c132298564981b5335361784d4fe"
            case .tempFor(let lat, let lon):
                return "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=4754c132298564981b5335361784d4fe"
        }
    }
}
