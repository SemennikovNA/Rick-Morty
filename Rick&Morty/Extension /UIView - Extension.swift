//
//  UIView - Extension.swift
//  Rick&Morty
//
//  Created by Nikita on 29.02.2024.
//

import UIKit

extension UIView {
    
    /// Add subviews method and off translates autoresizing mask into constraints
    func addSubviews(_ view: UIView...) {
        view.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
}
