//
//  SearchViewModelTests.swift
//  weather-appTests
//
//  Created by Jean paul Massoud on 2024-05-29.
//

import Combine
import XCTest

@testable import Domain
@testable import weather_app

final class SearchViewModelTests: XCTestCase {

    @MainActor fileprivate let viewModel = SearchViewModel()
    fileprivate var cancellables: Set<AnyCancellable> = []
    fileprivate enum Status { case idle, searching }

    override func tearDownWithError() throws {
        cancellables.forEach { $0.cancel() }
    }
    
    
    @MainActor
    func testFetchDataWithEmptyQuery() async throws {
        let retrieved = XCTestExpectation(description: "Data retrieved successfully")
        let cancellable = viewModel.$locations.sink { locations in
            if locations.isEmpty {
                retrieved.fulfill()
            }
        }
        XCTAssertTrue(viewModel.locations.isEmpty)
        viewModel.getLocations(query: "")
        await fulfillment(of: [retrieved], timeout: 1)
        cancellable.cancel()
        XCTAssertTrue(viewModel.locations.isEmpty)
    }
    
    @MainActor
    func testFetchDataWithAnyQuery() async throws {
        let retrieved = XCTestExpectation(description: "Data retrieved successfully")
        let cancellable = viewModel.$locations.sink { locations in
            if !locations.isEmpty {
                retrieved.fulfill()
            }
        }
        XCTAssertTrue(viewModel.locations.isEmpty)
        viewModel.getLocations(query: "London")
        await fulfillment(of: [retrieved], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.locations.isEmpty)
    }
    
    @MainActor
    func testFetchTemprature() async throws {
        let retrieved = XCTestExpectation(description: "Data retrieved successfully")
        let cancellable = viewModel.$temprature.sink { temprature in
            if let _ = temprature {
                retrieved.fulfill()
            }
        }
        XCTAssertTrue(viewModel.temprature == nil)
        viewModel.getTemprature(location: Locations.Location(name: "", lat: 0, lon: 0, country: ""))
        await fulfillment(of: [retrieved], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.temprature == nil)
    }
    
}
