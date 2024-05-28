//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

public struct Temprature: BaseModel {

    public let id = UUID()
    public let main: Main

    enum CodingKeys: String, CodingKey {
        case main = "main"
    }
    
    public struct Main: BaseModel {
        public let id = UUID()
        public let temp: Double

        enum CodingKeys: String, CodingKey {
            case temp = "temp"
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
    
}

#if DEBUG
extension Temprature {
    static var mockData: Data! = """
    {
      "main": {
          "temp": 298.48,
        }
    }
    """.data(using: .utf8)
}
#endif

#if DEBUG
extension Temprature.Main {
    static var mockData: Data! = nil
}
#endif
