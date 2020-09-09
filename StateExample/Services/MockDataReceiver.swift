//
//  MockDataReceiver.swift
//  State Example
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import Foundation

protocol DataReceiverProtocol {
    func subscribeToItemChanges(_ subscriber: @escaping ([MockBackendItem]) -> Void)
}

/// Provides a stream of currencies with random exchange rates
/// Assuming that here we would have stream of data received from the back end
class MockDataReceiver: DataReceiverProtocol {
    // MARK: - Constants
    private enum Constants {
        static let currenciesCoefficients: [String: Double] = ["BTC": 11000,
                                                                "ETH": 380,
                                                                "XRP": 0.29,
                                                                "LTC": 57,
                                                                "EUR": 1.18,
                                                                "GBP": 1.31,
                                                                "CAD": 0.76,
                                                                "CHF": 1.1]
        static let currencyFrom = "USD"
        static let buyMarkup = 1.01
        static let sellMarkup = 0.99
        static let refreshRate: TimeInterval = 5
    }

    // MARK: - Properties
    private var subscribers = [([MockBackendItem]) -> Void]()
    private var timer: Timer?

    // MARK: - Public Methods
    func subscribeToItemChanges(_ subscriber: @escaping ([MockBackendItem]) -> Void) {
        if timer == nil {
            startNewTimer()
        }
        subscribers.append(subscriber)
        generateNewRandomItems()
    }

    // MARK: - Private Methods
    private func startNewTimer() {
        timer = .scheduledTimer(withTimeInterval: Constants.refreshRate, repeats: true, block: { _ in
            self.generateNewRandomItems()
        })
    }

    private func generateNewRandomItems() {
        var mockedItems = [MockBackendItem]()
        for item in Constants.currenciesCoefficients {
            let nominalExchangeRate = randomNominalExchangeRate(currencyCoefficient: item.value)
            mockedItems.append(.init(currencyTo: item.key,
                                     currencyFrom: Constants.currencyFrom,
                                     buyRate: nominalExchangeRate * Constants.buyMarkup,
                                     sellRate: nominalExchangeRate * Constants.sellMarkup,
                                     change: (nominalExchangeRate - item.value) / item.value,
                                     created: randomTimeInterval()
                )
            )
        }

        for subscriber in subscribers {
            subscriber(mockedItems)
        }
    }

    private func randomNominalExchangeRate(currencyCoefficient: Double) -> Double {
        return Double.random(in: 90..<110) / 100 * currencyCoefficient
    }

    private func randomTimeInterval() -> Date {
        return Date(timeIntervalSinceNow: -TimeInterval.random(in: 0..<10000))
    }
}
