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
    private let repo = LocationsRepository()
    private var task: Task<Void, Never>? = nil
    
    @Published private(set) var locations = [Locations.Location]()
    @Published var query: String = ""
    private var storedLocations = [Locations.Location]()

    init() {
        $query
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .sink { newValue in
                self.fetchLocations(query: newValue)
            }
            .store(in: &bag)
    }

    internal func fetchLocations(query: String) {
        if query.isEmpty {
            self.setLocations(nil)
        } else {
            self.task?.cancel()
            self.task = Task {
                do {
                    let res = try await repo.getLocations(name: query)
                    print(res)
                    self.locations = res.list
                }
                catch is CancellationError {
                    print("\(TAG).fetchLocations() task is cancelled")
                } catch {
                    print("\(TAG).fetchLocations() error: ", error)
                }
            }
        }
    }

    private func setLocations(_ locations: [Locations.Location]? = nil) {
        withAnimation {
            if let res = locations,
                res != self.locations
            {
                self.locations = res
            }
            else {
                self.locations = []
            }
        }
    }
}
