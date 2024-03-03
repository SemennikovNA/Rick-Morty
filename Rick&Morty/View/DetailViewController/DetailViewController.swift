//
//  DetailViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - User interface element

    private var episodesCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<DetailViewSection, EpisodesModel>?
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
        EpisodesModel(episodesName: "Pilot", episodesSeasonNumber: "Episode: 1, Season: 1", episodesDate: "December 2, 2013"),
        EpisodesModel(episodesName: "Lawnmower Dog", episodesSeasonNumber: "Episode: 2, Season: 1", episodesDate: "December 9, 2013"),
        EpisodesModel(episodesName: "Anatomy Park", episodesSeasonNumber: "Episode: 3, Season: 1", episodesDate: "December 16, 2013")
    ]
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupConstraints()
        configureDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailInfoView.layoutIfNeeded()
        detailOriginView.layoutIfNeeded()
        episodesCollectionView.layoutIfNeeded()
        characterImage.layer.cornerRadius = characterImage.frame.size.width / 9
    }
    
    //MARK: - Private method
    
    private func setupView() {
        // Setup view
        view.backgroundColor = .backBlue
        view.addSubviews(characterImage, characterStackView, infoLabel, detailInfoView, originLabel, detailOriginView, episodesLabel)
        
        // Setup charecter stack view
        characterStackView.addArrangedSubviews(characterNameLabel, characterStatusLabel)
        
        // Setup navigation bar
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonClick))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItems = [backButton]
        
        // Call method's
        setupCollectionView()
    }
    
    //MARK: - Objective - C method
    
    @objc func backButtonClick() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewCompositionalLayout

extension DetailViewController {
    
    // Methods for register cell's
    private func infoRegisterCells() -> UICollectionView.CellRegistration<InfoCollectionViewCell, Info> {
        return UICollectionView.CellRegistration<InfoCollectionViewCell, Info> { (cell, indexPath, item) in
            cell.setupDataForCell(with: item)
        }
    }
    
    private func originRegisterCells() -> UICollectionView.CellRegistration<OriginCollectionViewCell, OriginModel> {
        return UICollectionView.CellRegistration { (cell, indexPath, item) in
            cell.setupDataForCell(with: item)
        }
    }
    
    private func episodesRegisterCell() -> UICollectionView.CellRegistration<EpisodesCollectionViewCell, EpisodesModel> {
        return UICollectionView.CellRegistration { (cell, indexPath, item) in
            cell.setupDataForEpisodesCell(with: item)
        }
    }
    
    // Setup collection view
    private func setupCollectionView() {
        // Setup collection view
        episodesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupEpisodesCompositionalLayout())
        episodesCollectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: EpisodesCollectionViewCell.id)
        episodesCollectionView.backgroundColor = .clear
        view.addSubviews(episodesCollectionView)
    }
    
    // Create compositional layout
    private func setupEpisodesCompositionalLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(327),
            heightDimension: .absolute(86))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: 18, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = 5
        section.contentInsetsReference = .layoutMargins
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    
    // Setup datasource for episodes collection view
    private func configureDataSource() {
        let infoCell = infoRegisterCells()
        let originCell = originRegisterCells()
        let episodesCell = episodesRegisterCell()
        dataSource = UICollectionViewDiffableDataSource<DetailViewSection, EpisodesModel>(collectionView: episodesCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: EpisodesModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionViewCell.id, for: indexPath) as! EpisodesCollectionViewCell
            cell.layoutIfNeeded()
            let dataForCell = self.episodeList[indexPath.row]
            cell.setupDataForEpisodesCell(with: dataForCell)
            return cell
        }
        var snapShot = NSDiffableDataSourceSnapshot<DetailViewSection, EpisodesModel>()
        snapShot.appendSections([.episodes])
        snapShot.appendItems(episodeList)
        dataSource?.apply(snapShot, animatingDifferences: false)
        
    }
}

//MARK: - Private extension

private extension DetailViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Character image
            characterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            characterImage.heightAnchor.constraint(equalToConstant: 148),
            characterImage.widthAnchor.constraint(equalToConstant: 148),
            characterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Character stack view
            characterStackView.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 20),
            characterStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterStackView.widthAnchor.constraint(equalToConstant: 200),
            characterStackView.heightAnchor.constraint(equalToConstant: 50),
            
            // Info label
            infoLabel.topAnchor.constraint(equalTo: characterStackView.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoLabel.widthAnchor.constraint(equalToConstant: 50),
            infoLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Detail info view
            detailInfoView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5),
            detailInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailInfoView.heightAnchor.constraint(equalToConstant: 125),
            detailInfoView.widthAnchor.constraint(equalToConstant: 330),
            
            // Origin label
            originLabel.topAnchor.constraint(equalTo: detailInfoView.bottomAnchor, constant: 5),
            originLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            originLabel.widthAnchor.constraint(equalToConstant: 50),
            originLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Detail origin view
            detailOriginView.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 5),
            detailOriginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailOriginView.heightAnchor.constraint(equalToConstant: 80),
            detailOriginView.widthAnchor.constraint(equalToConstant: 330),
            
            // Episodes label
            episodesLabel.topAnchor.constraint(equalTo: detailOriginView.bottomAnchor, constant: 5),
            episodesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            episodesLabel.widthAnchor.constraint(equalToConstant: 100),
            episodesLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Episodes collection view
            episodesCollectionView.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor),
            episodesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            episodesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            episodesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
    }
}
