//
//  AppCoordinator.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}

final class AppCoordinator {
    private let window: UIWindow
    private var children: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        displayMarvelFlow()
    }
}
private extension AppCoordinator {
    func displayMarvelFlow() {
        let navigationController = UINavigationController()
        let coordinator = MarvelCoordinator(navigationController: navigationController)
        coordinator.start()
        children.append(coordinator)
        replaceRootViewController(navigationController)
    }
}
private extension AppCoordinator {
    func replaceRootViewController(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

