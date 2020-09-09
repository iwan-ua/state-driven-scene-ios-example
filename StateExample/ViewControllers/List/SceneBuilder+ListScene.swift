//
//  SceneBuilder+ListScene.swift
//  StateExample
//
//  Created by Iwan Protchenko on 27.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import Foundation

extension SceneBuilder {
    func sceneListOfItems() -> ListViewController {
        let viewController = ListViewController()
        let viewModel = ListViewModel(dataReceiver: MockDataReceiver()) { [weak viewController] state in
            viewController?.state = state
        }
        viewController.viewModel = viewModel
        return viewController
    }
}
