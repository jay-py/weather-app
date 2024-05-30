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
    private var storedCoord: CLLocationCoordinate2D? = nil
    
    @Published private(set) var currentTemprature: Temprature?
    
    private let minDistance = 500.0 // meters
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation() {
        print(">> requesting user's location")
        manager.requestLocation()
    }
    
    func stopMonitoringLocationChanges() {
        manager.stopMonitoringSignificantLocationChanges()
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if [.denied, .notDetermined].contains(manager.authorizationStatus){
            print(">> requesting location permission")
            self.manager.requestWhenInUseAuthorization()
        }
        else {
            print(">> location permission granted")
            manager.startMonitoringSignificantLocationChanges()
            manager.requestLocation()
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let newCoord = locations.first?.coordinate,
           shouldUpdateCurrentLocationTemprature(oldCoord: self.storedCoord, newCoord: newCoord){
            print(">> received user's location")
            self.storedCoord = newCoord
            self.getTemprature(for: newCoord.latitude, lon: newCoord.longitude)
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("\(TAG) CL manager error: ", error.localizedDescription)
    }
    
    private func shouldUpdateCurrentLocationTemprature(oldCoord: CLLocationCoordinate2D?, newCoord: CLLocationCoordinate2D) -> Bool {
        guard let oldCoord else { return true }
        let oldLocation = CLLocation(latitude: oldCoord.latitude, longitude: oldCoord.longitude)
        let newLocation = CLLocation(latitude: newCoord.latitude, longitude: newCoord.longitude)
        let distance = oldLocation.distance(from: newLocation)
        print(">> should update current location temprature: ", distance > minDistance)
        return distance > minDistance
    }
    
    private func getTemprature(for lat: Double, lon: Double) {
        print(">> getting temprature for user's location")
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
