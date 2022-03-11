//
//  MovieViewControllerTests.swift
//  moviesTests
//
//  Created by Fernando Zaldivar on 9/3/22.
//

import XCTest
@testable import movies

class MovieViewControllerTests: XCTestCase {

    func testLaunchingFlow() {
        let movie = Movie(title: "Movie", poster: "Poster", backdrop: "Backdrop", overview: "Overview", rate: 8.0)
        let viewController = MovieViewController.fromStoryboard()
        viewController.coordinator = MovieCoordinator(movie: movie, navigationController: UINavigationController())
        viewController.viewModel = MovieViewModel(movie: movie)

        XCTAssert(viewController.navigationController?.viewControllers.last != viewController,
                  "Expected navigation from launch view controller.")
    }
}
