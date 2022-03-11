//
//  ReusableView.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import UIKit

protocol ReusableView: AnyObject { }

extension ReusableView where Self: UIView {
    
    static var reusableIdentifier: String {
        let name = String(describing: self)
        return name
    }
}
