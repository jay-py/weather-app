//
//  weather_appUITests.swift
//  weather-appUITests
//
//  Created by Jean paul Massoud on 2024-05-30.
//

import XCTest

final class weather_appUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testSearch() throws {
        app.launch()
        let app = XCUIApplication()
        app.buttons["location.magnifyingglass"].tap()
        app.navigationBars["Search"].searchFields["Enter a location"].tap()
        app.typeText("par")
        app.collectionViews.buttons["Paris, FR"].tap()
        XCTAssert(app.staticTexts["paris (FR)"].exists)
        XCTAssert(app.staticTexts["25.33 Celsius"].exists)
    }
    
    func testConvertToImperial() throws {
        app.launch()
        app.buttons["location.magnifyingglass"].tap()
        app.navigationBars["Search"].searchFields["Enter a location"].tap()
        app.typeText("par")
        app.collectionViews.buttons["Paris, FR"].tap()
        app.buttons["IM"].tap()
        XCTAssert(app.staticTexts["paris (FR)"].exists)
        XCTAssert(app.staticTexts["77.59 Fahrenheit"].exists)
    }
}
