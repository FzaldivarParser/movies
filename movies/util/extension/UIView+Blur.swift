//
//  UIView+Blur.swift
//  movies
//
//  Created by Fernando Zaldivar on 9/3/22.
//

import UIKit

protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {

    func addBlur(_ alpha: CGFloat = 0.5) {
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        self.addSubview(effectView)
    }
}

extension UIView: Bluring {}
