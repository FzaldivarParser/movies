//
//  Coordinated.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation

protocol Coordinated {
    associatedtype AssociatedCoordinator
    var coordinator: AssociatedCoordinator! { get set }
}
