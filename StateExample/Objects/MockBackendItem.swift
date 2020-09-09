//
//  MockBackendItem.swift
//  State Example
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import Foundation

struct MockBackendItem {
    let currencyTo: String
    let currencyFrom: String
    let buyRate: Double
    let sellRate: Double
    let change: Double
    let created: Date
}
