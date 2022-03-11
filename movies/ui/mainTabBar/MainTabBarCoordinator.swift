//
//  MainTabBarCoordinator.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation

final class MainTabBarCoordinator: BaseCoordinator {

    // MARK: - Navigation methods

    override func navigate(animated: Bool) {
        let tabViewController = MainTabBarViewController(coordinator: self)
        navigationController.pushViewController(tabViewController, animated: false)
    }
}
