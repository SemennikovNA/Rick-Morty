//
//  HeaderForSection.swift
//  Rick&Morty
//
//  Created by Nikita on 04.03.2024.
//

import UIKit

final class HeaderForSection: UICollectionReusableView {
    
    //MARK: - Properti
    
    static let id = "header"
    
    //MARK: - User interface elemenets
    
    let titleLabel = UILabel()
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call method's
        setupHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoder init(:) error")
    }
    
    //MARK: - Private
    
    private func setupHeaderView() {
        // Setup header view
        self.addSubviews(titleLabel)
        
        // Setup elements
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
