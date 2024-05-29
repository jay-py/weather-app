//
//  weather_appApp.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI

@main
struct app: App {
    init() {
        configureURLCache()
    }
    
    var body: some Scene {
        WindowGroup {
            TempratureView()
        }
    }
    
    private func configureURLCache() {
        let memoryCapacity = 50 * 1024 * 1024 // 50 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "WeatherAppCachePath")
        URLCache.shared = cache
    }
}
