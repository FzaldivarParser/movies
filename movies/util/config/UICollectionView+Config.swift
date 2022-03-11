//
//  UICollectionView+Config.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

extension UICollectionView {

    func registerCell<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }

        return cell
    }
}

extension UICollectionViewCell: ReusableView { }
extension UICollectionViewCell: NibLoadableView { }
