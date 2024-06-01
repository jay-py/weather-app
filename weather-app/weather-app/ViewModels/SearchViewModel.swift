//
//  SearchViewModel.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import Combine
import Domain
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    private let TAG = "SearchViewModel"
    private let repo = ApiRepository()
    private var task: Task<Void, Never>? = nil
    private var bag = Set<AnyCancellable>()
    
    @Published private(set) var locations = [Locations.Location]()
    @Published private(set) var temprature: Temprature? = nil
    @Published var query: String = ""
    
    init() {
        $query
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { newValue in
                self.getLocations(query: newValue)
            }
            .store(in: &bag)
    }
    
    internal func getLocations(query: String) {
        if query.isEmpty {
            self.setLocations(nil)
        } else {
            self.task?.cancel()
            self.task = Task {
                do {
                    let res = try await repo.getLocations(query: query)
                    try Task.checkCancellation()
                    setLocations(res.list)
                    print(">> success getting locations for \(query): \(res.list)")
                }
                catch {
                    if Task.isCancelled {
                        print("\(TAG).fetchLocations() is canceled")
                    }
                    else {
                        print("\(TAG).fetchLocations() error: ", error)
                    }
                }
            }
        }
    }
    
    private func setLocations(_ locations: [Locations.Location]? = nil) {
        withAnimation {
            if let res = locations {
                if res != self.locations {
                    self.locations = res
                }
            }
            else {
                self.locations = []
            }
        }
    }
    
    func getTemprature(location: Locations.Location) {
        Task {
            do {
                let temprature = try await repo.getTemprature(lat: location.lat, lon: location.lon)
                self.temprature = temprature
                print(">> success getting temprature for \(location): \(temprature)")
            }
            catch {
                print("\(TAG).getTemprature() error: ", error)
            }
        }
    }
    
}
