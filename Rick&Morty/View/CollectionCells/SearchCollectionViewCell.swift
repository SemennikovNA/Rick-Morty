//
//  SearchCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Nikita on 29.03.2024.
//

import UIKit

class SearchCollectionViewCell: ParentCollectionCell {
    
    //MARK: - Properties
    
    static let reuseID = "SearchCell"
    private let imageManager = SDWebImageManager.shared
    
    //MARK: - User interface elements
    
    private let contentCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    private let characterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private let characterNameLabel = UILabel(font: UIFont(name: "gilroy-black", size: 20), textAlignment: .left, textColor: .white)
    private let raceLabel = UILabel(font: UIFont(name: "gilroy-black", size: 17), textAlignment: .left, textColor: .white)
    private let genderLabel = UILabel(font: UIFont(name: "gilroy-regular", size: 17), textAlignment: .left, textColor: .white)
    private let characterStatusLabel = UILabel(font: UIFont(name: "gilroy-regular", size: 15), textAlignment: .left, textColor: .green)
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        self.layer.cornerRadius = self.frame.size.width / 15
        self.clipsToBounds = true
        characterImage.layer.cornerRadius = characterImage.frame.size.width / 10
        characterImage.clipsToBounds = true
    }
    
    //MARK: - Method
    
    func setupDataForCell(with model: CharacterResult) {
        let statusValue = model.status
        switch statusValue {
        case .alive:
            characterStatusLabel.textColor = .green
            characterStatusLabel.text = statusValue.rawValue
        case .dead:
            characterStatusLabel.textColor = .red
            characterStatusLabel.text = statusValue.rawValue
        case .unknown:
            characterStatusLabel.textColor = .yellow
            characterStatusLabel.text = statusValue.rawValue
        }
        self.characterNameLabel.text = model.name
        self.raceLabel.text = model.species
        self.genderLabel.text = model.gender.rawValue
        guard let urlImage = URL(string: model.image) else { return }
        imageManager.setImageFromUrl(image: self.characterImage, url: urlImage)
    }
    
    override func setupCellUI() {
        super.setupCellUI()
        self.addSubviews(contentCellView)
        contentCellView.addSubviews(characterImage, characterNameLabel, raceLabel, genderLabel, characterStatusLabel)
        self.backgroundColor = .cellBackBlue
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            // Content cell view
            contentCellView.topAnchor.constraint(equalTo: self.topAnchor),
            contentCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Character image
            characterImage.topAnchor.constraint(equalTo: contentCellView.topAnchor, constant: 5),
            characterImage.leadingAnchor.constraint(equalTo: contentCellView.leadingAnchor, constant: 5),
            characterImage.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor, constant: -5),
            characterImage.widthAnchor.constraint(equalToConstant: 100),
            
            // Character name label
            characterNameLabel.topAnchor.constraint(equalTo: contentCellView.topAnchor, constant: 10),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 15),
            characterNameLabel.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor, constant: -10),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // Race label
            raceLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 15),
            raceLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 15),
            raceLabel.heightAnchor.constraint(equalToConstant: 15),
            
            // Gender label
            genderLabel.topAnchor.constraint(equalTo: raceLabel.bottomAnchor, constant: 15),
            genderLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 15),
            genderLabel.heightAnchor.constraint(equalToConstant: 15),

            // Character status label
            characterStatusLabel.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor, constant: -15),
            characterStatusLabel.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor, constant: -15),
            characterStatusLabel.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
}
