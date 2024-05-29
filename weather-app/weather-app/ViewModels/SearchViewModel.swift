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
    private var bag = Set<AnyCancellable>()
    private let locationRepo = LocationsRepository()
    private let tempratureRepo = TempratureRepository()

    private var task: Task<Void, Never>? = nil
    
    @Published private(set) var locations = [Locations.Location]()
    @Published var query: String = ""
    @Published var result: Temprature? = nil
    private var storedLocations = [Locations.Location]()

    init() {
        $query
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { newValue in
                self.fetchLocations(query: newValue)
            }
            .store(in: &bag)
    }

    private func fetchLocations(query: String) {
        if query.isEmpty {
            self.setLocations(nil)
        } else {
            self.task?.cancel()
            self.task = Task {
                do {
                    let res = try await locationRepo.getLocations(name: query)
                    try Task.checkCancellation()
                    setLocations(res.list)
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
                let temprature = try await tempratureRepo.getTemprature(lat: location.lat, lon: location.lon)
                self.result = temprature
            }
            catch {
                print("\(TAG).getTemprature() error: ", error)
            }
        }
    }
    
}
