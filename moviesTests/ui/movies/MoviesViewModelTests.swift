//
//  MoviesViewModelTests.swift
//  moviesTests
//
//  Created by Fernando Zaldivar on 9/3/22.
//

import XCTest
@testable import movies

final class MoviesViewModelTests: XCTestCase {

    // MARK: - Properties

    var viewModel: MoviesViewModel!
    var errorViewModel: MoviesViewModel!
    var dataSource: [MovieCellViewModel]!

    // MARK: - Lifecycle methods

    override func setUp() {
        viewModel = MoviesViewModel(category: .popular, networkClient: NetworkClient(configuration: MockPolicyConfiguration()))
        errorViewModel = MoviesViewModel(category: .popular, networkClient: NetworkClient(configuration: MockErrorPolicyConfiguration()))
        dataSource = (0...25).map { MovieCellViewModel(Movie(title: "Title",
                                                             poster: "\($0)",
                                                             backdrop: "backdrop",
                                                             overview: "overview",
                                                             rate: 9.9))
        }
    }

    override func tearDown() {
        viewModel = nil
        errorViewModel = nil
    }

    // MARK: - Test methods

    func testPopularMovies() {
        viewModel = MoviesViewModel(category: .popular, networkClient: NetworkClient(configuration: MockPolicyConfiguration()))

        let expectation = XCTestExpectation(description: "Load completed.")

        viewModel.loadMovies { result  in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to load: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testPopularMoviesError() {
        errorViewModel = MoviesViewModel(category: .popular, networkClient: NetworkClient(configuration: MockErrorPolicyConfiguration()))

        let expectation = XCTestExpectation(description: "Load failed.")

        errorViewModel.loadMovies { result  in
            switch result {
            case .success:
                XCTFail("Load successful")
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testTopRatedMovies() {
        viewModel = MoviesViewModel(category: .topRated, networkClient: NetworkClient(configuration: MockPolicyConfiguration()))

        let expectation = XCTestExpectation(description: "Load completed.")

        viewModel.loadMovies { result  in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to load: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testTopRatedMoviesError() {
        errorViewModel = MoviesViewModel(category: .topRated, networkClient: NetworkClient(configuration: MockErrorPolicyConfiguration()))

        let expectation = XCTestExpectation(description: "Load failed.")

        errorViewModel.loadMovies { result  in
            switch result {
            case .success:
                XCTFail("Load successful")
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testUpcomingMovies() {
        viewModel = MoviesViewModel(category: .upcoming, networkClient: NetworkClient(configuration: MockPolicyConfiguration()))

        let expectation = XCTestExpectation(description: "Load completed.")

        viewModel.loadMovies { result  in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to load: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testUpcomingMoviesError() {
        errorViewModel = MoviesViewModel(category: .upcoming, networkClient: NetworkClient(configuration: MockErrorPolicyConfiguration()))

        let expectation = XCTestExpectation(description: "Load failed.")

        errorViewModel.loadMovies { result  in
            switch result {
            case .success:
                XCTFail("Load successful")
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testUpdateSearchTextEmpty() {
        viewModel.updateSearchText("")
        XCTAssertEqual(viewModel.filterDataSource, viewModel.dataSource)
    }

    func testUpdateSearchText() {
        viewModel = MoviesViewModel(category: .popular, dataSource: dataSource, networkClient: NetworkClient(configuration: MockPolicyConfiguration()))
        viewModel.updateSearchText("Title")
        XCTAssertEqual(viewModel.filterDataSource, viewModel.dataSource)
    }

    func testLoadMoreIfNeeded() {
        viewModel = MoviesViewModel(category: .popular, dataSource: dataSource, networkClient: NetworkClient(configuration: MockPolicyConfiguration()))
        XCTAssertTrue(viewModel.loadMoreIfNeeded(18))
    }

    func testMovie() {
        viewModel = MoviesViewModel(category: .popular, dataSource: dataSource, networkClient: NetworkClient(configuration: MockPolicyConfiguration()))
        XCTAssertNotNil(viewModel.movie(0))
    }

    func testRestartMovies() {
        viewModel.restartMovies()
        XCTAssertTrue(viewModel.dataSource.isEmpty)
    }

    func testFetchMovies() {
        viewModel.fetchMovies()
        XCTAssertEqual(viewModel.filterDataSource, viewModel.dataSource)
    }
}
