//
//  File.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Foundation
protocol BaseModel: Codable, Identifiable, Equatable {
    #if DEBUG
        static var mockData: Data! { get }
    #endif
}
