//
//  DetailViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - User interface element
    
    private let detailInfoView = DetailInfoView()
    private let detailOriginView = DetailOriginView()
    private let characterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    private let characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "rick")
        return image
    }()
    private let infoLabel = UILabel(text: "Info", font: UIFont(name: "gilroy-black", size: 17), textAlignment: .left, textColor: .white)
    private let originLabel = UILabel(text: "Origin", font: UIFont(name: "gilroy-black", size: 17), textAlignment: .left, textColor: .white)
    private let episodesLabel = UILabel(text: "Episodes", font: UIFont(name: "gilroy-black", size: 17), textAlignment: .left, textColor: .white)
    private var characterNameLabel = UILabel(text: "Rick Sanchez", font: UIFont(name: "gilroy-black", size: 22), textAlignment: .center, textColor: .white)
    private var characterStatusLabel = UILabel(text: "Alive", font: UIFont(name: "gilroy-black", size: 18), textAlignment: .center, textColor: .textGreen)
    
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
        detailOriginView.layoutIfNeeded()
        characterImage.layer.cornerRadius = characterImage.frame.size.width / 9
    }
    
    //MARK: - Private method
    
    private func setupView() {
        // Setup view
        view.backgroundColor = .backBlue
        view.addSubviews(characterImage, characterStackView, infoLabel, detailInfoView, originLabel, detailOriginView, episodesLabel)
        
        // Setup charecter stack view
        characterStackView.addArrangedSubviews(characterNameLabel, characterStatusLabel)
        
    }
}

private extension DetailViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Character image
            characterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
            detailInfoView.heightAnchor.constraint(equalToConstant: 125),
            detailInfoView.widthAnchor.constraint(equalToConstant: 330),
            
            // Origin label
            originLabel.topAnchor.constraint(equalTo: detailInfoView.bottomAnchor, constant: 20),
            originLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            originLabel.widthAnchor.constraint(equalToConstant: 50),
            originLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Detail origin view
            detailOriginView.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 10),
            detailOriginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailOriginView.heightAnchor.constraint(equalToConstant: 80),
            detailOriginView.widthAnchor.constraint(equalToConstant: 330),
            
            // Episodes label
            episodesLabel.topAnchor.constraint(equalTo: detailOriginView.bottomAnchor, constant: 20),
            episodesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            episodesLabel.widthAnchor.constraint(equalToConstant: 100),
            episodesLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
