//
//  DetailOriginView.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import UIKit

class DetailOriginView: UIView {
    
    //MARK: - User interface element
    
    let planetImageView: UIView = {
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
        image.layer.masksToBounds = true
        return image
    }()
    private let planetTitleLabel = UILabel(text: "Planet", font: UIFont(name: "gilroy-black", size: 13), textAlignment: .left, textColor: .textGreen)
    private var planetNameLabel = UILabel(text: "Earth", font: UIFont(name: "gilroy-black", size: 17), textAlignment: .left, textColor: .white)
    
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
        self.layer.cornerRadius = self.frame.size.width / 20
        planetImageView.layer.cornerRadius = 10
    }
    
    //MARK: - Private method
    
    private func setupView() {
        self.backgroundColor = .viewBackGray
        self.addSubviews(planetImageView, planetNameLabel, planetTitleLabel)
        planetImageView.addSubviews(planetImage)
        planetImageView.layer.cornerRadius = planetImageView.frame.size.width / 6
    }
    
    private func setupDataForView(with model: String) {
//        planetNameLabel.text = ""
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Planet image view
            planetImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            planetImageView.heightAnchor.constraint(equalToConstant: 60),
            planetImageView.widthAnchor.constraint(equalToConstant: 60),
            planetImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            // Planet image
            planetImage.topAnchor.constraint(equalTo: planetImageView.topAnchor),
            planetImage.leadingAnchor.constraint(equalTo: planetImageView.leadingAnchor),
            planetImage.trailingAnchor.constraint(equalTo: planetImageView.trailingAnchor),
            planetImage.bottomAnchor.constraint(equalTo: planetImageView.bottomAnchor),
            
            // Planet name label
            planetNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            planetNameLabel.leadingAnchor.constraint(equalTo: planetImage.trailingAnchor, constant: 15),
            
            // Planet title label
            planetTitleLabel.leadingAnchor.constraint(equalTo: planetImage.trailingAnchor, constant: 17),
            planetTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
        ])
    }
}
