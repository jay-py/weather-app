//
//  Location.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation

public struct Locations: BaseModel {

    public let id = UUID()
    public let list: [Location]

    // Custom decoding to map the top-level array to the items property
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var locations = [Location]()
        while !container.isAtEnd {
            let location = try container.decode(Location.self)
            locations.append(location)
        }
        self.list = locations
    }
    
    public struct Location: BaseModel {
        public let id = UUID()
        public let name: String
        public let lat: Double
        public let lon: Double
        public let country: String

        
        enum CodingKeys: String, CodingKey {
            case name = "name"
            case lat = "lat"
            case lon = "lon"
            case country = "country"
        }
    }
}

#if DEBUG
extension Locations {
    static var mockData: Data! = """
    [
        {
            "name":"London",
            "lat":51.5073219,
            "lon":-0.1276474,
            "country":"GB"
        },
        {
            "name":"Paris",
            "lat":51.5073219,
            "lon":-0.1276474,
            "country":"FR"
        },
        {
            "name":"Stockholm",
            "lat":51.5073219,
            "lon":-0.1276474,
            "country":"SE"
        }
    ]
    """.data(using: .utf8)
}
#endif


#if DEBUG
extension Locations.Location {
    static var mockData: Data! = nil
}
#endif
