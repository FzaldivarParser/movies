//
//  MainTabBarViewModel.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation

final class MainTabBarViewModel {

    // MARK: - Properties

    let popularTitle: String
    let topRatedTitle: String
    let upcomingTitle: String

    // MARK: - Initializer

    init() {
        popularTitle = MainTabBarViewControllerStrings.popular.localized
        topRatedTitle = MainTabBarViewControllerStrings.topRated.localized
        upcomingTitle = MainTabBarViewControllerStrings.upcoming.localized
    }
}
