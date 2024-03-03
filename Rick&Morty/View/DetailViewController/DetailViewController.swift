//
//  DetailViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - User interface element
    private var episodesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    private var dataSource: UICollectionViewDiffableDataSource<MainViewSection, EpisodesModel>?
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
    
    //MARK: - Propertie
    let episodeList: [EpisodesModel] = [
        EpisodesModel(episodesName: "Pilot", episodesSeasonNumber: "Episode: 1, Season: 1", episodesDate: "December 2, 2013")
    ]
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
        view.addSubviews(characterImage, characterStackView, infoLabel, detailInfoView, originLabel, detailOriginView, episodesLabel, episodesCollectionView)
        
        // Setup charecter stack view
        characterStackView.addArrangedSubviews(characterNameLabel, characterStatusLabel)
        
        // Setup navigation bar
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonClick))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItems = [backButton]
    }
    
    //MARK: - Objective - C method
    
    @objc func backButtonClick() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewCompositionalLayout

extension DetailViewController {
    
    // Setup collection view
    private func setupCollectionView() {
        episodesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupEpisodesCompositionalLayout())
        episodesCollectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: EpisodesCollectionViewCell.id)
    }
    
    // Create compositional laoput
    private func setupEpisodesCompositionalLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(327), heightDimension: .absolute(86))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        section.contentInsetsReference = .automatic
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // Setup datasource for episodes collection view
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MainViewSection, EpisodesModel>.init(collectionView: episodesCollectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: EpisodesModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionViewCell.id, for: indexPath) as! EpisodesCollectionViewCell
            cell.layoutIfNeeded()
            let dataForCell = self.episodeList[indexPath.row]
            cell.setupDataForEpisodesCell(with: dataForCell)
            return cell

        })
    }
}

//MARK: - Private extension

private extension DetailViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Character image
            characterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
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
            
            // Episodes collection view
            episodesCollectionView.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 10),
            episodesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            episodesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
