//
//  MovieViewController.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

final class MovieViewController: UIViewController, StoryboardBased, View, Coordinated {

    // MARK: - IBOutlets

    @IBOutlet var headerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var rateLabel: UILabel!
    var headerBlurImageView: UIImageView!

    // MARK: - Properties

    var coordinator: MovieCoordinator!
    var viewModel: MovieViewModel!
    private let offsetHeaderStop: CGFloat = 120.0
    private var offsetHeader: CGFloat = 120.0
    private let distanceHeader: CGFloat = 35.0

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    // MARK: - Configure Methods

    private func initialSetup() {
        configureHeader()
        configureLabels()
        tabBarController?.tabBar.isHidden = true
    }

    private func configureHeader() {
        imageView.imageFromURL(urlString: viewModel.imageURL())
        headerBlurImageView = UIImageView(frame: headerView.bounds)
        headerBlurImageView.imageFromURL(urlString: viewModel.imageURL())
        headerBlurImageView.addBlur()
        headerBlurImageView?.contentMode = .scaleAspectFill
        headerBlurImageView?.alpha = 0.0
        headerView.insertSubview(headerBlurImageView, aboveSubview: headerView)
    }

    private func configureLabels() {
        titleLabel.text = viewModel.movie.title
        overviewTextView.text = viewModel.movie.overview
        rateLabel.text = viewModel.rate()
    }

    private func setHeaderViewAnimation(_ offset: CGFloat) {
        let alphaImageView = (offsetHeader - offset)
        headerView.alpha = alphaImageView > 0.0 ? alphaImageView / 100 : 0.0
    }
}

// MARK: - UIScrollViewDelegate

extension MovieViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var headerTransform = CATransform3DIdentity
        if offset <= 0 {
            headerView.alpha = 1
            let headerScaleFactor: CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            headerView.alpha = 1
        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offsetHeaderStop, -offset), 0)
            headerBlurImageView?.alpha = min(1.0, (offset - offsetHeader)/distanceHeader)
            setHeaderViewAnimation(offset)
        }

        headerView.layer.transform = headerTransform
    }
}
