//
//  CollectionViewCell.swift
//  Rick&Morty
//
//  Created by Nikita on 29.02.2024.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let id = "reuseCell"
    
    //MARK: - User interface elements
    
    private let imageManager = SDWebImageManager.shared
    private lazy var contentViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackBlue
        return view
    }()
    
    lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var characterNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.font = .boldSystemFont(ofSize: 20)
        label.font = UIFont(name: "gilroy-black", size: 20)
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
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.size.width / 10
        self.clipsToBounds = true
        characterImage.layer.cornerRadius = characterImage.frame.size.width / 10
    }
    
    //MARK: - Method
    
    func setupDataForCell(name: String, image: String) {
        let urlForImage = URL(string: image)!
        characterNameTitle.text = name
        imageManager.setImageFromUrl(image: characterImage, url: urlForImage)
    }
    
    //MARK: - Private method
    
    private func setupCellUI() {
        contentView.addSubviews(contentViewCell)
        contentViewCell.addSubviews(characterImage, characterNameTitle)
    }
}

//MARK: - Private extension

private extension CharactersCollectionViewCell {
    
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
            characterImage.topAnchor.constraint(equalTo: contentViewCell.topAnchor, constant: 5),
            characterImage.leadingAnchor.constraint(equalTo: contentViewCell.leadingAnchor, constant: 5),
            characterImage.trailingAnchor.constraint(equalTo: contentViewCell.trailingAnchor, constant: -5),
            characterImage.bottomAnchor.constraint(equalTo: contentViewCell.bottomAnchor, constant: -40),
        
            // Character name title
            characterNameTitle.leadingAnchor.constraint(equalTo: contentViewCell.leadingAnchor, constant: 10),
            characterNameTitle.trailingAnchor.constraint(equalTo: contentViewCell.trailingAnchor, constant: -10),
            characterNameTitle.bottomAnchor.constraint(equalTo: contentViewCell.bottomAnchor, constant: -10)
        ])
    }
}
