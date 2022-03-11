//
//  MovieCollectionViewCell.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet var movieImageView: UIImageView!

    // MARK: - Properties

    var viewModel: MovieCellViewModel!

    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configure methods

    func configureCell(_ viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
        movieImageView.imageFromURL(urlString: viewModel.imageURL())
    }
}
