//
//  MoviesCache.swift
//  movies
//
//  Created by Fernando Zaldivar on 10/3/22.
//

import Foundation

final class MoviesManager {

    // MARK: - Properties

    let category: MovieCategory
    private let maxItems: Int

    // MARK: - Initializer

    init(category: MovieCategory) {
        self.category = category
        self.maxItems = 4
    }

    // MARK: - Utility methods

    func saveMovies(_ movies: Movies) {
        let savedMovies = Array(movies.results.prefix(maxItems))
        CacheManager.shared.save(key: category.rawValue, data: savedMovies)
    }

    func fetchMovies() -> [Movie]? {
        return CacheManager.shared.fetch(key: category.rawValue, type: Movie.self)
    }
}
