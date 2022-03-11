//
//  MovieCellViewModel.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation


final class MovieCellViewModel: CellViewModel {

    // MARK: - Properties

    let movie: Movie

    // MARK: - Initializer

    init(_ movie: Movie) {
        self.movie = movie
    }

    // MARK: - Utility methods

    func imageURL() -> String {
        return String(format: ApiConfig.shared.posterUrl, movie.poster)
    }
}
