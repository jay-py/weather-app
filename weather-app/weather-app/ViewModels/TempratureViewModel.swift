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
    private let repo = ApiRepository()
    private let manager = CLLocationManager()
    private var task: Task<Void, Never>? = nil
    private var hasUserLocation: Bool = false
    
    @Published private(set) var currentTemprature: Temprature?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    private func requestAuthorisation() {
        if [.denied, .notDetermined].contains(manager.authorizationStatus){
            print(">> requesting location permission")
            self.manager.requestWhenInUseAuthorization()
        }
    }
    
    
    func requestLocation() {
        print(">> requesting user's location")
        requestAuthorisation()
        hasUserLocation = false
        manager.requestLocation()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = locations.first?.coordinate, !hasUserLocation {
            print(">> received user's location")
            self.hasUserLocation = true
            self.getTemprature(for: coord.latitude, lon: coord.longitude)
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("\(TAG) CL manager error: ", error.localizedDescription)
    }
    
    
    private func getTemprature(for lat: Double, lon: Double) {
        self.task?.cancel()
        self.task = Task {
            do {
                let res = try await repo.getTemprature(lat: lat, lon: lon)
                try Task.checkCancellation()
                await MainActor.run {
                    self.currentTemprature = res
                }
                print(">> success getting temprature for user's location: \(res)")
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
