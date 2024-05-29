//
//  APIEndpoints.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

enum APIEndpoints {
    case search(String)
    case temp(lat:Double, lon: Double)

    var value: String {
        switch self {
            case .search(let string):
                return "https://api.openweathermap.org/geo/1.0/direct?q=\(string)&limit=5&appid=4754c132298564981b5335361784d4fe"
            case .temp(let lat, let lon):
                return "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=4754c132298564981b5335361784d4fe"
        }
    }
}
