//
//  TestDataReceiver.swift
//  StateExampleTests
//
//  Created by Iwan Protchenko on 20.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

@testable import StateExample

class TestDataReceiver: DataReceiverProtocol {
    var testData = [MockBackendItem]()

    func subscribeToItemChanges(_ subscriber: @escaping ([MockBackendItem]) -> Void) {
        subscriber(testData)
    }
}
