//
//  TempratureView.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-29.
//

import Foundation
import Domain
import CoreLocation

final class TempratureViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let TAG = "TempratureViewModel"
    private let tempratureRepo = TempratureRepository()
    private let manager = CLLocationManager()
    private var task: Task<Void, Never>? = nil
    private var hasUserLocation: Bool = false
    
    @Published private(set) var currentTemprature: Temprature?
    
    override init() {
        super.init()
        manager.delegate = self
        requestAuthorisation()
    }
    
    private func requestAuthorisation() {
        if [.denied, .notDetermined].contains(manager.authorizationStatus){
            self.manager.requestWhenInUseAuthorization()
        }
    }
    
    
    func requestLocation() {
        requestAuthorisation()
        hasUserLocation = false
        manager.requestLocation()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coords = locations.first?.coordinate, !hasUserLocation {
            self.hasUserLocation = true
            self.getTemprature(for: coords.latitude, lon: coords.longitude)
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("\(TAG) CL manager error: ", error.localizedDescription)
    }
    
    
    private func getTemprature(for lat: Double, lon: Double) {
        self.task?.cancel()
        self.task = Task {
            do {
                let res = try await tempratureRepo.getTemprature(lat: lat, lon: lon)
                try Task.checkCancellation()
                await MainActor.run {
                    self.currentTemprature = res
                }
            }
            catch {
                if Task.isCancelled {
                    print("\(TAG).getTemprature() is canceled")
                }
                else {
                    print("\(TAG).getTemprature() error: ", error)
                }
            }
        }
    }
    
}
