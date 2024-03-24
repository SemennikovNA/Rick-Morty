//
//  InfoCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Nikita on 03.03.2024.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - User interface element
    private let contentCellView = UIView()
    private let speciesLabel = UILabel(text: "Species:", font: UIFont(name: "gilroy-regular", size: 16), textAlignment: .left, textColor: .lightGray)
    private let typeLabel = UILabel(text: "Type:", font: UIFont(name: "gilroy-regular", size: 16), textAlignment: .left, textColor: .lightGray)
    private let genderLabel = UILabel(text: "Gender:", font: UIFont(name: "gilroy-regular", size: 16), textAlignment: .left, textColor: .lightGray)
    private var speciesValueLabel = UILabel(font: UIFont(name: "gilroy-black", size: 16), textAlignment: .right, textColor: .white)
    private var typeValueLabel = UILabel(font: UIFont(name: "gilroy-black", size: 16), textAlignment: .right, textColor: .white)
    private var genderValueLabel = UILabel(font: UIFont(name: "gilroy-black", size: 16), textAlignment: .right, textColor: .white)
    
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
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.size.width / 20
        self.clipsToBounds = true
    }
    
    //MARK: - Method
    
    func setupDataForCell(with model: InfoModel) {
        speciesValueLabel.text = model.species
        typeValueLabel.text = model.type
        genderValueLabel.text = model.gender
    }
    
    //MARK: - Private method
    
    private func setupView() {
        // Setup view
        self.backgroundColor = .viewBackGray
        self.addSubviews(contentCellView)
        contentCellView.addSubviews(speciesLabel, typeLabel, genderLabel, speciesValueLabel, typeValueLabel, genderValueLabel)
        
        // Setup label
        typeValueLabel.adjustsFontSizeToFitWidth = true
        typeValueLabel.minimumScaleFactor = 0.5
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Content cell view
            contentCellView.topAnchor.constraint(equalTo: self.topAnchor),
            contentCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Species label
            speciesLabel.topAnchor.constraint(equalTo: contentCellView.topAnchor, constant: 10),
            speciesLabel.leadingAnchor.constraint(equalTo: contentCellView.leadingAnchor, constant: 10),
            speciesLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Type label
            typeLabel.leadingAnchor.constraint(equalTo: contentCellView.leadingAnchor, constant: 10),
            typeLabel.heightAnchor.constraint(equalToConstant: 30),
            typeLabel.centerYAnchor.constraint(equalTo: contentCellView.centerYAnchor),
            
            // Gender label
            genderLabel.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor, constant: -10),
            genderLabel.leadingAnchor.constraint(equalTo: contentCellView.leadingAnchor, constant: 10),
            genderLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Species value label
            speciesValueLabel.topAnchor.constraint(equalTo: contentCellView.topAnchor, constant: 10),
            speciesValueLabel.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor, constant: -10),
            speciesValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Type value label
            typeValueLabel.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor, constant: -10),
            typeValueLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 5),
            typeValueLabel.heightAnchor.constraint(equalToConstant: 30),
            typeValueLabel.centerYAnchor.constraint(equalTo: contentCellView.centerYAnchor),
            
            // Gender value label
            genderValueLabel.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor, constant: -10),
            genderValueLabel.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor, constant: -10),
            genderValueLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
