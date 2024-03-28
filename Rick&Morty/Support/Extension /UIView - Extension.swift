//
//  UIView - Extension.swift
//  Rick&Morty
//
//  Created by Nikita on 29.02.2024.
//

import UIKit

extension UIView {
    
    //MARK: - Properties
    
    static var safeAreaInset: UIEdgeInsets {
        if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets
        } else {
            // Возвращаем UIEdgeInsets.zero для устройств с iOS ниже 11.0
            return UIEdgeInsets.zero
        }
    }


    //MARK: - Method
    
    /// Add subviews method and off translates autoresizing mask into constraints
    func addSubviews(_ view: UIView...) {
        view.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
}
