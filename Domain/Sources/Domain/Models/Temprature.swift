//
//  Temprature.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

public struct Temprature: BaseModel {

    public let id = UUID()
    public let main: Main
    public let sys: Sys
    public let name: String

    enum CodingKeys: String, CodingKey {
        case main = "main"
        case sys = "sys"
        case name = "name"
    }
    
    public struct Main: BaseModel {
        public let id = UUID()
        public let temp: Double

        enum CodingKeys: String, CodingKey {
            case temp = "temp"
        }
    }
    
    public struct Sys: BaseModel {
        public let id = UUID()
        public let country: String

        enum CodingKeys: String, CodingKey {
            case country = "country"
        }
    }
    
    public var metricTemp: String {
        get {
            return String(format: "%.2f", self.main.temp - 273.15)
        }
    }
    
    public var imperialTemp: String {
        get {
            return String(format: "%.2f", (self.main.temp - 273.15) * 9/5 + 32)
        }
    }
    
    public var country: String {
        get {
            return sys.country
        }
    }
    
}

#if DEBUG
extension Temprature {
    static var mockData: Data! = """
    {
        "main": {
              "temp": 298.48,
            },
        "sys": {
            "country": "FR"
            },
        "name": "paris"
    }
    """.data(using: .utf8)
}
#endif

#if DEBUG
extension Temprature.Main {
    static var mockData: Data! = nil
}
#endif


#if DEBUG
extension Temprature.Sys {
    static var mockData: Data! = nil
}
#endif
