//
//  ListViewModel.swift
//  State Example
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import UIKit

class ListViewModel {
    // MARK: - Typealiases
    typealias StateHandler = (ListViewController.State) -> Void

    // MARK: - Properties
    private let stateHandler: StateHandler
    private let dataReceiver: DataReceiverProtocol
    private let sceneCoordinator = MockSceneCoordinator()
    private let sceneBuilder = SceneBuilder()

    // MARK: - Initialization Methods
    init(dataReceiver: DataReceiverProtocol, stateHandler: @escaping StateHandler) {
        self.dataReceiver = dataReceiver
        self.stateHandler = stateHandler
        startGeneratingState()
    }

    // MARK: - Private Methods
    private func startGeneratingState() {
        dataReceiver.subscribeToItemChanges { [weak self] items in
            guard let self = self else { return }
            let stateItems: [ListViewController.Item]  = items.map(self.convertToListItem)
            self.stateHandler(.init(items: stateItems))
        }
    }

    private func convertToListItem(item: MockBackendItem) -> ListViewController.Item {
        // Here UI State and Back End Object are not much different
        // But in real project this place could have complex calculations
        return .init(state: .init(currency: item.currencyTo,
                                  rateChange: item.change,
                                  buyRate: item.buyRate,
                                  sellRatte: item.sellRate),
                     action: { [weak self] in
                        self?.selectItem(item: item)
                     })
    }

    private func selectItem(item: MockBackendItem) {
        sceneCoordinator.push(sceneBuilder.sceneItemDetails(item: item))
    }
}
