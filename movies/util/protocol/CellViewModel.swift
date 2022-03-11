//
//  CellViewModel.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation

class CellViewModel: ViewModel {

    // MARK: - Properties

    var title: String
    private(set) var uuid: UUID

    // MARK: - Initializer

    init(_ title: String = "") {
        self.title = title
        self.uuid = UUID()
    }
}

// MARK: - Hashable

extension CellViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: CellViewModel, rhs: CellViewModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
