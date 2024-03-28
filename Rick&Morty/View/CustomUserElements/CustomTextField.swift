//
//  CustomTextField.swift
//  Rick&Morty
//
//  Created by Nikita on 28.03.2024.
//

import UIKit

class CustomTextField: UITextField {
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call method's
        setupViewElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        self.layer.cornerRadius = self.frame.width / 20
        self.clipsToBounds = true
    }
    
    //MARK: - Method
    
    func setupViewElement() {
        self.tintColor = .white
        self.textColor = .white
        self.keyboardType = .webSearch
        self.placeholder = "Enter something"
        self.backgroundColor = .viewBackGray
        
        // Call method's
        setupLeftView()
    }
    
    func setupLeftView() {
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        leftView!.backgroundColor = .red
    }
}
