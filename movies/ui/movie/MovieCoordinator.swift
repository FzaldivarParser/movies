//
//  MovieCoordinator.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

final class MovieCoordinator: BaseCoordinator {

    // MARK: - Properties

    private let movie: Movie

    // MARK: - Initializers

    init(movie: Movie, navigationController: UINavigationController) {
        self.movie = movie
        super.init(navigationController: navigationController)
        navigationController.isNavigationBarHidden = false
    }

    // MARK: - Navigation methods

    override func navigate(animated: Bool) {
        let viewController = MovieViewController.fromStoryboard()
        viewController.viewModel = MovieViewModel(movie: movie)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: animated)
    }
}
