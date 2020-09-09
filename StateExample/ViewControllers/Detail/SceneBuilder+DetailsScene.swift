//
//  SceneBuilder+DetailsScene.swift
//  StateExample
//
//  Created by Iwan Protchenko on 27.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import Foundation

extension SceneBuilder {
    func sceneItemDetails(item: MockBackendItem) -> DetailViewController {
        let viewController = DetailViewController()
        let viewModel = DetailViewModel(item: item) { [weak viewController] state in
            viewController?.state = state
        }
        viewController.viewModel = viewModel
        return viewController
    }
}
