//
//  DetailInfoView.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import UIKit

class DetailInfoView: UIView {
    
    //MARK: - User interface element
    
    private let speciesLabel = UILabel(text: "Species:", font: UIFont(name: "gilroy-black", size: 16), textAlignment: .left, textColor: .lightGray)
    private let typeLabel = UILabel(text: "Type:", font: UIFont(name: "gilroy-black", size: 16), textAlignment: .left, textColor: .lightGray)
    private let genderLabel = UILabel(text: "Gender:", font: UIFont(name: "gilroy-black", size: 16), textAlignment: .left, textColor: .lightGray)
    private var speciesValueLabel = UILabel(text: "Human", font: UIFont(name: "gilroy-black", size: 16), textAlignment: .right, textColor: .white)
    private var typeValueLabel = UILabel(text: "None", font: UIFont(name: "gilroy-black", size: 16), textAlignment: .right, textColor: .white)
    private var genderValueLabel = UILabel(text: "Male", font: UIFont(name: "gilroy-black", size: 16), textAlignment: .right, textColor: .white)
    
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
    }
    
    //MARK: - Private method
    
    private func setupView() {
        // Setup view
        self.backgroundColor = .viewBackGray
        self.addSubviews(speciesLabel, typeLabel, genderLabel, speciesValueLabel, typeValueLabel, genderValueLabel)
    }
    
    private func setupDataForView(with model: String) {
//        speciesValueLabel.text = ""
//        typeValueLabel.text = ""
//        genderValueLabel.text = ""
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Species label
            speciesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            speciesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            speciesLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Type label
            typeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            typeLabel.heightAnchor.constraint(equalToConstant: 30),
            typeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            // Gender label
            genderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            genderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            genderLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Species value label
            speciesValueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            speciesValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            speciesValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Type value label
            typeValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            typeValueLabel.heightAnchor.constraint(equalToConstant: 30),
            typeValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            // Gender value label
            genderValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            genderValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            genderValueLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
