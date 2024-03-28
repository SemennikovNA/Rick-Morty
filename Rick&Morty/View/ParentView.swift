//
//  ParentView.swift
//  Rick&Morty
//
//  Created by Nikita on 28.03.2024.
//

import UIKit

class ParentView: UIView {
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call method's
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
    func setupView() { }
    
    func setupConstraints() { }
    
}
