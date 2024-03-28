//
//  UIImage - Extension.swift
//  Rick&Morty
//
//  Created by Nikita on 28.03.2024.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        return resizedImage
    }
}
