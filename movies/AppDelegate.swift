//
//  AppDelegate.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: MainTabBarCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initialLoading()
        return true
    }

    // MARK: - Initial loader

    private func initialLoading() {
        rootCoordinator = MainTabBarCoordinator(navigationController: UINavigationController())
        rootCoordinator.navigate(animated: false)
        rootCoordinator.navigationController.isNavigationBarHidden = true

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootCoordinator.navigationController
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
    }
}

