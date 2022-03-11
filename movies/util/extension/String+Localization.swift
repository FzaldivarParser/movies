//
//  String+Localization.swift
//  movies
//
//  Created by Fernando Zaldivar on 10/3/22.
//

import Foundation

extension String {

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
