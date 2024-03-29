//
//  CustomTextField.swift
//  Rick&Morty
//
//  Created by Nikita on 28.03.2024.
//

import UIKit

class CustomTextField: UITextField {
    
    let dropMenuButton: UIButton = {
        let button = UIButton()
        button.setTitle("Character", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return button
    }()
    
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
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
        leftView?.addSubviews(dropMenuButton)
        leftView!.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            dropMenuButton.topAnchor.constraint(equalTo: self.leftView!.topAnchor, constant: 5),
            dropMenuButton.leadingAnchor.constraint(equalTo: self.leftView!.leadingAnchor, constant: 10),
            dropMenuButton.trailingAnchor.constraint(equalTo: self.leftView!.trailingAnchor, constant: -10),
            dropMenuButton.bottomAnchor.constraint(equalTo: self.leftView!.bottomAnchor, constant: -5)
        ])
    }
}
