//
//  MovieViewModel.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation

final class MovieViewModel: ViewModel {

    // MARK: - Properties

    var title: String
    let movie: Movie

    // MARK: - Initializer

    init(movie: Movie) {
        self.title = ""
        self.movie = movie
    }

    // MARK: - Utility methods

    func imageURL() -> String {
        guard let backdrop = movie.backdrop else {
            return String(format: ApiConfig.shared.posterUrl, movie.poster)
        }
        
        return String(format: ApiConfig.shared.imageUrl, backdrop)
    }

    func rate() -> String {
        return String(format: "%.1f", movie.rate)
    }
}
