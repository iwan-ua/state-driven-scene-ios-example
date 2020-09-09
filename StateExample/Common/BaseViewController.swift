//
//  BaseViewController.swift
//  State Example
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import UIKit

/// At the time of ViewDidLoat the UIViewController already has the state
/// So on viewDidLoad the reloadState call is made
class BaseViewController: UIViewController {
    // MARK: - Properties
    var viewModel: Any?

    func reloadState() {}

    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadState()
    }
}
