//
//  MoviesViewController.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

final class MoviesViewController: UIViewController, StoryboardBased, View, Coordinated {

    // MARK: - Outlets

    @IBOutlet var moviesCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - Properties

    var coordinator: MoviesCoordinator!
    var viewModel: MoviesViewModel!
    typealias MoviesDataSource = UICollectionViewDiffableDataSource<Int, MovieCellViewModel>
    private var collectionViewDataSource: MoviesDataSource!
    private var refreshControl: UIRefreshControl!

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Configure Methods

    private func initialSetup() {
        configureResfreshControl()
        configureCollectionView()
        checkForMovies()
        searchBar.searchTextField.leftView?.tintColor = .white
    }

    private func configureCollectionView() {
        moviesCollectionView.registerCell(MovieCollectionViewCell.self)
        moviesCollectionView.refreshControl = refreshControl
        moviesCollectionView.alwaysBounceVertical = true
        collectionViewDataSource = prepareDataSource()
        collectionViewDataSource.apply(viewModel.snapshot, animatingDifferences: true)
    }

    private func configureResfreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
    }

    // MARK: - Utility methods

    private func checkForMovies() {
        Connectivity.isConnectedToInternet() ? loadMovies() : fetchMovies()
    }

    private func fetchMovies() {
        noInternetMessage()
        viewModel.fetchMovies()
        collectionViewDataSource.apply(self.viewModel.snapshot, animatingDifferences: false)
    }

    private func noInternetMessage() {
        tabBarController?.showAlertToUser(message: viewModel.noInternetText,
                                          style: .alert,
                                          actions: [UIAlertAction(title: viewModel.okText, style: .default, handler: nil)],
                                          completion: {
            UIView.animate(withDuration: 0.5, animations: {
                self.moviesCollectionView.contentOffset = CGPoint.zero
            })
        })
    }

    private func loadMovies() {
        viewModel.loadMovies { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                self.collectionViewDataSource.apply(self.viewModel.snapshot, animatingDifferences: false)
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }

    private func loadMoreIfNeeded(_ index: Int) {
        guard viewModel.loadMoreIfNeeded(index) else { return }
        checkForMovies()
    }

    @objc private func refreshMovies() {
        viewModel.restartMovies()
        refreshControl.endRefreshing()
        checkForMovies()
    }
}


// MARK: - UICollectionViewDataSource

extension MoviesViewController {

    private func prepareDataSource() -> MoviesDataSource {
        return UICollectionViewDiffableDataSource(
            collectionView: moviesCollectionView,
            cellProvider: { [unowned self] collectionView, indexPath, cellViewModel -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieCollectionViewCell
                cell.configureCell(cellViewModel)
                self.loadMoreIfNeeded(indexPath.row)
                return cell
            }
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2.5
        return CGSize(width: width, height: width * 2)
    }
}

// MARK: - UICollectionViewDelegate

extension MoviesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.pushToMovie(viewModel.movie(indexPath.row))
    }
}

// MARK: - UISearchBarDelegate

extension MoviesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearchText(searchText)
        collectionViewDataSource.apply(viewModel.snapshot, animatingDifferences: true)
    }
}
