//
//  CustomTextField.swift
//  Rick&Morty
//
//  Created by Nikita on 28.03.2024.
//

import UIKit

class CustomTextField: ParentView {
    
    //MARK: - User interface elements
    
    var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter something"
        textField.textColor = .white
        textField.tintColor = .white
        textField.keyboardType = .webSearch
        return textField
    }()
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    override func setupView() {
        super.setupView()
        
        self.backgroundColor = .viewBackGray
        self.addSubviews(searchTextField)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            // Text field
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            searchTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
