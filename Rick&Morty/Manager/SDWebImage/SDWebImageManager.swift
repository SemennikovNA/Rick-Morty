//
//  WebImageManager.swift
//  Rick&Morty
//
//  Created by Nikita on 23.03.2024.
//

import Foundation
import SDWebImage


class SDWebImageManager {
    
    static let shared = SDWebImageManager()
    private init() { }
    
    func setImageFromUrl(image: UIImageView, url: URL) {
        image.sd_setImage(with: url)
    }
    
    func setImageForButton(with url: URL, for button: UIButton) {
        button.sd_setImage(with: url, for: .normal)
    }
}
