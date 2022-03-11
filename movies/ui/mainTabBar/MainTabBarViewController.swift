//
//  MainTabBarViewController.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

final class MainTabBarViewController: UITabBarController, Coordinated {

    // MARK: - Properties

    private let viewModel = MainTabBarViewModel()
    var coordinator: MainTabBarCoordinator!
    var tabPopularCoordinator: MoviesCoordinator!
    var tabTopRatedCoordinator: MoviesCoordinator!
    var tabUpcomingCoordinator: MoviesCoordinator!

    // MARK: - Initializer

    init(coordinator: MainTabBarCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator

        tabPopularCoordinator = MoviesCoordinator(category: .popular)
        tabTopRatedCoordinator = MoviesCoordinator(category: .topRated)
        tabUpcomingCoordinator = MoviesCoordinator(category: .upcoming)

        tabPopularCoordinator.navigate(animated: false)
        tabTopRatedCoordinator.navigate(animated: false)
        tabUpcomingCoordinator.navigate(animated: false)

        tabPopularCoordinator.navigationController.tabBarItem.title = viewModel.popularTitle
        tabTopRatedCoordinator.navigationController.tabBarItem.title = viewModel.topRatedTitle
        tabUpcomingCoordinator.navigationController.tabBarItem.title = viewModel.upcomingTitle

        let controllers = prepareNavigationItems()
        viewControllers = controllers.compactMap({ $0 })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    // MARK: - Configure methods

    private func initialSetup() {
        moreNavigationController.navigationBar.isHidden = true
        configureTabBar()
    }

    private func prepareNavigationItems() -> [UIViewController] {
        return [
            tabPopularCoordinator.navigationController,
            tabTopRatedCoordinator.navigationController,
            tabUpcomingCoordinator.navigationController
        ]
    }

    private func configureTabBar() {
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = .black
        tabBarItemAppearance.selected.iconColor = UIColor.red

        tabBarItemAppearance.normal.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 12) as Any,
            .foregroundColor: UIColor.gray
        ]

        tabBarItemAppearance.selected.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 12) as Any,
            .foregroundColor: UIColor.red
        ]

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
}
