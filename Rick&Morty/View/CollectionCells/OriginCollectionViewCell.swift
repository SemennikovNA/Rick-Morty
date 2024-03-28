//
//  OriginCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Nikita on 03.03.2024.
//

import UIKit

class OriginCollectionViewCell: ParentCollectionCell {
    
    //MARK: - User interface element
    
    private let contentCellView = UIView()
    private let planetImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .backBlue
        view.clipsToBounds = true
        return view
    }()
    private let planetImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .backBlue
        image.image = UIImage(named: "planet")
        image.contentMode = .center
        return image
    }()
    private let planetTitleLabel = UILabel(text: "Planet", font: UIFont(name: "gilroy-regular", size: 13), textAlignment: .left, textColor: .textGreen)
    private var planetNameLabel = UILabel(font: UIFont(name: "gilroy-black", size: 15), textAlignment: .left, textColor: .white)
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        self.layer.cornerRadius = self.frame.size.width / 20
        self.clipsToBounds = true
        planetImageView.layer.cornerRadius = 10
        planetImageView.clipsToBounds = true
    }
    
    //MARK: - Method
    
    func setupDataForCell(with model: OriginModel) {
        planetNameLabel.text = model.planetName
    }
    
    //MARK: - Method
    
    override func setupCellUI() {
        super.setupCellUI()
        
        self.backgroundColor = .viewBackGray
        self.addSubviews(contentCellView)
        contentCellView.addSubviews(planetImageView, planetNameLabel, planetTitleLabel)
        planetImageView.addSubviews(planetImage)
        
        // Setup planet name label
        planetNameLabel.adjustsFontSizeToFitWidth = true
        planetNameLabel.adjustsFontForContentSizeCategory = true
        planetNameLabel.minimumScaleFactor = 0.7
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            // Content cell view
            contentCellView.topAnchor.constraint(equalTo: self.topAnchor),
            contentCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Planet image view
            planetImageView.leadingAnchor.constraint(equalTo: contentCellView.leadingAnchor, constant: 10),
            planetImageView.heightAnchor.constraint(equalToConstant: 60),
            planetImageView.widthAnchor.constraint(equalToConstant: 60),
            planetImageView.centerYAnchor.constraint(equalTo: contentCellView.centerYAnchor),
            
            // Planet image
            planetImage.topAnchor.constraint(equalTo: planetImageView.topAnchor),
            planetImage.leadingAnchor.constraint(equalTo: planetImageView.leadingAnchor),
            planetImage.trailingAnchor.constraint(equalTo: planetImageView.trailingAnchor),
            planetImage.bottomAnchor.constraint(equalTo: planetImageView.bottomAnchor),
            
            // Planet name label
            planetNameLabel.topAnchor.constraint(equalTo: contentCellView.topAnchor, constant: 17),
            planetNameLabel.leadingAnchor.constraint(equalTo: planetImage.trailingAnchor, constant: 15),
            
            // Planet title label
            planetTitleLabel.leadingAnchor.constraint(equalTo: planetImage.trailingAnchor, constant: 17),
            planetTitleLabel.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor, constant: -15),
        ])
    }
}
