//
//  PopOverTableCell.swift
//  Rick&Morty
//
//  Created by Nikita on 29.03.2024.
//

import UIKit

class PopOverTableCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "TableCell"
    
    //MARK: - User interface elements
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        return image
    }()
    let titleLabel = UILabel(font: UIFont(name: "gilroy-regular", size: 15), textAlignment: .left, textColor: .white)
    
    //MARK: - Initialize

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        // Call function's
        setupCellUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private method
    
    private func setupCellUI() {
        self.addSubviews(iconImage, titleLabel)
        self.backgroundColor = .viewBackGray
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Icon image
            iconImage.topAnchor.constraint(equalTo: self.topAnchor),
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 50),
            
            // Title label
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
}
