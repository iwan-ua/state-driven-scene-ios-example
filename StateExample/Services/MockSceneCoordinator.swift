//
//  MockSceneCoordinator.swift
//  State Example 12
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import UIKit

class MockSceneCoordinator {
    // MARK: - Public Methods
    func push(_ viewController: UIViewController) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let navigationController = delegate.window!.rootViewController as! UINavigationController
        navigationController.pushViewController(viewController, animated: true)
    }
}
