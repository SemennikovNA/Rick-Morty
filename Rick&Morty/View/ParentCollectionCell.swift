//
//  ParentCollectionCell.swift
//  Rick&Morty
//
//  Created by Nikita on 29.03.2024.
//

import UIKit

class ParentCollectionCell: UICollectionViewCell {

    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call method's
        setupCellUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
   func setupCellUI() {}
    
    func setupConstraints() {}
}
