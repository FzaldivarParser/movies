//
//  CommonLocalizedStrings.swift
//  movies
//
//  Created by Fernando Zaldivar on 10/3/22.
//

import Foundation

enum MainTabBarViewControllerStrings: String, LocalizationProtocol {
    case popular = "main_tab_bar_view_controller_popular"
    case topRated = "main_tab_bar_view_controller_top_rated"
    case upcoming = "main_tab_bar_view_controller_upcoming"
}

enum MoviesViewControllerStrings: String, LocalizationProtocol {
    case noInternet = "movies_view_controller_no_internet"
    case ok = "movies_view_controller_ok"
}
