//
//  DetailViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - User interface element
    
    private var detailInfoView = DetailInfoView()
    private var characterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    private var characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "rick")
        return image
    }()
    private var characterNameLabel = UILabel(text: "Rick Sanchez", font: UIFont(name: "gilroy-black", size: 22), textAlignment: .center, textColor: .white)
    private var characterStatusLabel = UILabel(text: "Alive", font: UIFont(name: "gilroy-black", size: 18), textAlignment: .center, textColor: .textGreen)
    private var infoLabel = UILabel(text: "Info", font: UIFont(name: "gilroy-black", size: 17), textAlignment: .left, textColor: .white)
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailInfoView.layoutIfNeeded()
        characterImage.layer.cornerRadius = characterImage.frame.size.width / 9
    }
    
    //MARK: - Private method
    
    private func setupView() {
        // Setup view
        view.backgroundColor = .backBlue
        view.addSubviews(characterImage, characterStackView, infoLabel, detailInfoView)
        
        // Setup charecter stack view
        characterStackView.addArrangedSubviews(characterNameLabel, characterStatusLabel)
        
    }
}

private extension DetailViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        // Character image
            characterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            characterImage.heightAnchor.constraint(equalToConstant: 148),
            characterImage.widthAnchor.constraint(equalToConstant: 148),
            characterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        // Character stack view
            characterStackView.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 20),
            characterStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterStackView.widthAnchor.constraint(equalToConstant: 200),
            characterStackView.heightAnchor.constraint(equalToConstant: 50),
            
        // Info label
            infoLabel.topAnchor.constraint(equalTo: characterStackView.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoLabel.widthAnchor.constraint(equalToConstant: 50),
            infoLabel.heightAnchor.constraint(equalToConstant: 30),
            
        // Detail info view
            detailInfoView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            detailInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailInfoView.heightAnchor.constraint(equalToConstant: 124),
            detailInfoView.widthAnchor.constraint(equalToConstant: 327),
        ])
    }
}
