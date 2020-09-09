//
//  ListViewModelTests.swift
//  StateExampleTests
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import XCTest
@testable import StateExample

/// Tests code is to show how ViewModel can be tested
/// In your app you may check how data from back end converts into UI State that will be used to show the ViewController
/// Unlike the example here, the difference between back end data and UI State object may be big in real projects
class ListViewModelTests: XCTestCase {
    // MARK: - Properties
    let testDataReceiver = TestDataReceiver()

    // MARK: - Set up
    override func setUp() {
        testDataReceiver.testData = [.init(currencyTo: "GBP",
                                           currencyFrom: "USD",
                                           buyRate: 1.32,
                                           sellRate: 1.31,
                                           change: 0.01,
                                           created: Date())]
    }

    override func tearDown() {
        testDataReceiver.testData = []
    }

    // MARK: - Tests
    func testExample() {
        let currencyExpectation = self.expectation(description: "Currency must match")
        let buyRateExpectation = self.expectation(description: "Buy rate must match")
        _ = ListViewModel(dataReceiver: testDataReceiver) { state in
            if state.items[0].state.currency == "GBP" { currencyExpectation.fulfill() }
            if state.items[0].state.buyRate == 1.32 { buyRateExpectation.fulfill() }
        }
        wait(for: [currencyExpectation, buyRateExpectation], timeout: 1)
    }
}
