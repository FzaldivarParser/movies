//
//  MoviesViewModel.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

final class MoviesViewModel: ViewModel {

    // MARK: - Properties

    var title: String
    let category: MovieCategory
    let noInternetText: String
    let okText: String
    private var searchText: String
    private var currentNextPage: Int
    private let loadMoreThreshold: Int
    private let itemCount: Int
    private var loadedIndex: Int
    private var moviesManager: MoviesManager
    private (set) var dataSource: [MovieCellViewModel]
    private (set) var filterDataSource: [MovieCellViewModel]
    private let networkClient: PerformRequestProtocol

    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MovieCellViewModel>

    var snapshot: Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(filterDataSource)
        return snapshot
    }

    // MARK: - Initializer

    init(category: MovieCategory, dataSource: [MovieCellViewModel] = [], networkClient: PerformRequestProtocol = NetworkClient()) {
        self.title = ""
        self.searchText = ""
        self.category = category
        self.noInternetText = MoviesViewControllerStrings.noInternet.localized
        self.okText = MoviesViewControllerStrings.ok.localized
        self.currentNextPage = 1
        self.loadMoreThreshold = 3
        self.itemCount = 20
        self.loadedIndex = 0
        self.moviesManager = MoviesManager(category: category)
        self.dataSource = dataSource
        self.filterDataSource = dataSource
        self.networkClient = networkClient
    }

    // MARK: - Utility methods

    func loadMovies(completion: @escaping (Result<Void, Error>) -> Void) {
        networkClient.performRequest(route: router()) { [weak self] (result: Result<Movies, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let result):
                self.saveMovies(result)
                self.updateDataSource(result)
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadMoreIfNeeded(_ index: Int) -> Bool {
        let threshold = (itemCount * currentNextPage) - loadMoreThreshold
        if loadedIndex < threshold && index >= threshold && searchText.isEmpty {
            loadedIndex = index + loadMoreThreshold
            currentNextPage += 1
            return true
        }

        return false
    }

    func updateSearchText(_ text: String) {
        searchText = text
        filterDataSource = text.isEmpty ? dataSource
                                        : dataSource.filter({ $0.movie.title.lowercased().contains(searchText.lowercased())})
    }

    func movie(_ index: Int) -> Movie {
        return filterDataSource[index].movie
    }

    func restartMovies() {
        dataSource.removeAll()
        filterDataSource.removeAll()
        currentNextPage = 1
        loadedIndex = 0
    }

    func fetchMovies() {
        guard let movies = moviesManager.fetchMovies() else { return }
        updateDataSource(Movies(results: movies))
    }

    private func updateDataSource(_ movies: Movies) {
        dataSource.append(contentsOf: movies.results.map { MovieCellViewModel($0) })
        filterDataSource = dataSource
    }

    private func router() -> MovieRouter {
        switch category {
        case .popular:
           return MovieRouter.popular(currentNextPage)
        case .topRated:
            return MovieRouter.topRated(currentNextPage)
        case .upcoming:
            return MovieRouter.upcoming(currentNextPage)
        }
    }

    private func saveMovies(_ movies: Movies) {
        guard currentNextPage == 1 else { return }
        moviesManager.saveMovies(movies)
    }
}
