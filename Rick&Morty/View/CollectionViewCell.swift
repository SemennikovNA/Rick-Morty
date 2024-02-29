//
//  CollectionViewCell.swift
//  Rick&Morty
//
//  Created by Nikita on 29.02.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let id = "reuseCell"
    
    //MARK: - User interface elements
    
    private lazy var contentViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackBlue
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var characterNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    //MARK: - Inititalize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call method's
        setupCellUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.height / 5
    }
    
    override func layoutIfNeeded() {
        layer.cornerRadius = frame.size.height / 5
        characterImage.layer.cornerRadius = characterImage.frame.size.height / 5
    }
    //MARK: - Method
    
    func setupDataForCell(with model: Item) {
        let image = model.characterImage
        characterNameTitle.text = model.characterName
        characterImage.image = UIImage(named: image)
    }
    
    //MARK: - Private method
    
    private func setupCellUI() {
        contentView.clipsToBounds = true
        contentView.addSubviews(contentViewCell)
        contentViewCell.addSubviews(characterImage, characterNameTitle)
    }
}

//MARK: - Private extension

private extension CollectionViewCell {
    /// Setup constraints for collection view cell
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Content view
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Content view cell
            contentViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Character image
            characterImage.topAnchor.constraint(equalTo: contentViewCell.topAnchor, constant: 10),
            characterImage.leadingAnchor.constraint(equalTo: contentViewCell.leadingAnchor, constant: 10),
            characterImage.trailingAnchor.constraint(equalTo: contentViewCell.trailingAnchor, constant: -10),
            characterImage.bottomAnchor.constraint(equalTo: contentViewCell.bottomAnchor, constant: -40),
        
            // Character name title
            characterNameTitle.leadingAnchor.constraint(equalTo: contentViewCell.leadingAnchor, constant: 10),
            characterNameTitle.trailingAnchor.constraint(equalTo: contentViewCell.trailingAnchor, constant: -10),
            characterNameTitle.bottomAnchor.constraint(equalTo: contentViewCell.bottomAnchor, constant: -10)
        ])
    }
}
