//
//  MarvelCoordinator.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import Foundation
import UIKit

final class MarvelCoordinator: Coordinator {
    let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let marvelViewModel = MarvelViewModel(coordinator: self)
        let marvelViewController = MarvelViewController()
        marvelViewController.viewModel = marvelViewModel
        navigationController.setViewControllers([marvelViewController], animated: true)
    }
}

