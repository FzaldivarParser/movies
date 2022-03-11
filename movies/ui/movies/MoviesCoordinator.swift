//
//  MoviesCoordinator.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

final class MoviesCoordinator: BaseCoordinator {

    // MARK: - Properties

    private let category: MovieCategory
    
    // MARK: - Initializers

    init(category: MovieCategory, navigationController: UINavigationController = UINavigationController()) {
        self.category = category
        super.init(navigationController: navigationController)
    }

    // MARK: - Navigation methods

    override func navigate(animated: Bool) {
        let viewController = MoviesViewController.fromStoryboard()
        viewController.viewModel = MoviesViewModel(category: category)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: animated)
    }

    func pushToMovie(_ movie: Movie) {
        let coordinator = MovieCoordinator(movie: movie, navigationController: navigationController)
        coordinator.navigate(animated: true)
    }
}

