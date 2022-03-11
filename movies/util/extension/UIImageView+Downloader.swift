//
//  UIImageView+Downloader.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit
import Nuke

extension UIImageView {

    func imageFromURL(urlString: String) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        Nuke.loadImage(with: urlString, into: self) { _ in
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
