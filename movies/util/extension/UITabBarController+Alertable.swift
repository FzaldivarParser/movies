//
//  UITabBarController+Alertable.swift
//  movies
//
//  Created by Fernando Zaldivar on 9/3/22.
//

import UIKit

extension UITabBarController {

    func showAlertToUser(title: String? = nil,
                         message: String? = nil,
                         style: UIAlertController.Style,
                         actions: [UIAlertAction],
                         completion: (() -> Void)? = nil) {
        configureAlertProperties(title: title, message: message, style: style, actions: actions, completion: completion)
    }

    private func configureAlertProperties(title: String? = nil,
                                          message: String? = nil,
                                          style: UIAlertController.Style,
                                          actions: [UIAlertAction],
                                          completion: (() -> Void)? = nil,
                                          customizeAlert: ((UIAlertController, String?) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if let customAlert = customizeAlert {
            customAlert(alert, message)
        }
        
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: completion)
    }
}
