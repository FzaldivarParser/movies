//
//  MovieViewModelTests.swift
//  moviesTests
//
//  Created by Fernando Zaldivar on 9/3/22.
//

import XCTest
@testable import movies

final class MovieViewModelTests: XCTestCase {

    // MARK: - Properties

    var viewModel: MovieViewModel!
    var movie: Movie!

    // MARK: - Lifecycle methods

    override func setUp() {
        movie = Movie(title: "Deadpool", poster: "Poster", backdrop: "Backdrop", overview: "Overview", rate: 6.5)
        viewModel = MovieViewModel(movie: movie)
    }

    override func tearDown() {
        viewModel = nil
    }

    // MARK: - Test methods

    func testImageURL() {
        XCTAssertTrue(viewModel.imageURL().contains(movie.backdrop ?? ""))
    }

    func testImageURLNoBackdrop() {
        movie = Movie(title: "Deadpool", poster: "Poster", backdrop: nil, overview: "Overview", rate: 6.5)
        viewModel = MovieViewModel(movie: movie)
        XCTAssertTrue(viewModel.imageURL().contains(movie.poster))
    }

    func testRate() {
        XCTAssertEqual(String(format: "%.1f", movie.rate), viewModel.rate())
    }
}
