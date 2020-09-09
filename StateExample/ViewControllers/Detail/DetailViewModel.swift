//
//  DetailViewModel.swift
//  State Example 12
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import UIKit

class DetailViewModel {
    // MARK: - Typealiases
    typealias StateHandler = (DetailViewController.State) -> Void

    // MARK: - Properties
    private let stateHandler: StateHandler
    private let item: MockBackendItem

    // MARK: - Initialization Methods
    init(item: MockBackendItem, stateHandler: @escaping StateHandler) {
        self.item = item
        self.stateHandler = stateHandler
        generateState()
    }

    // MARK: - Private Methods
    private func generateState() {
        // Here UI State and Back End Object are not much different
        // But in real project this place could have complex calculations
        stateHandler(.init(created: item.created,
                           currencyFrom: item.currencyFrom,
                           currencyTo: item.currencyTo,
                           buyRate: item.buyRate,
                           sellRate: item.sellRate))
    }
}
