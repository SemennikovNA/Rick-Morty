//
//  UIStackView - Extension.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ view: UIView...) {
        view.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }
    }
}
