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
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }),
                let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                return keyWindow.safeAreaInsets
            }
        } else if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets
        }
        return UIEdgeInsets.zero
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
