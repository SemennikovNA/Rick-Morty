//
//  UILabel - Extension.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import UIKit

extension UILabel {
    
    convenience init(text: String = "", font: UIFont? = UIFont(name: "gilroy-black", size: 22), textAlignment: NSTextAlignment, textColor: UIColor) {
        self.init(frame: .infinite)
        self.text = text
        self.font = font
        self.textAlignment = textAlignment
        self.textColor = textColor
    }
}
