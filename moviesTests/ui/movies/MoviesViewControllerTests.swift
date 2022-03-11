//
//  MoviesViewControllerTests.swift
//  moviesTests
//
//  Created by Fernando Zaldivar on 9/3/22.
//

import XCTest
@testable import movies

class MoviesViewControllerTests: XCTestCase {

    func testLaunchingFlow() {
        let viewController = MoviesViewController.fromStoryboard()
        viewController.coordinator = MoviesCoordinator(category: .popular)
        viewController.viewModel = MoviesViewModel(category: .popular)

        XCTAssert(viewController.navigationController?.viewControllers.last != viewController,
                  "Expected navigation from launch view controller.")
    }
}
