//
//  View.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation

protocol View {
    associatedtype AssociatedViewModel
    var viewModel: AssociatedViewModel! { get set }
}
