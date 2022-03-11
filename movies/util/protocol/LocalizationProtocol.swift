//
//  LocalizationProtocol.swift
//  movies
//
//  Created by Fernando Zaldivar on 10/3/22.
//

import Foundation

protocol LocalizationProtocol { }

extension LocalizationProtocol where Self: RawRepresentable {

    var localized: String {
        guard let localizedString = self.rawValue as? String else { return "" }
        return localizedString.localized()
    }

    func localized(args: CVarArg...) -> String {
        guard let localizedString = self.rawValue as? String else { return "" }
        return String(format: localizedString.localized(), locale: .current, arguments: args)
    }
}
