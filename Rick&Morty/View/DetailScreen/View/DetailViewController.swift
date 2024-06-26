//
//  DetailViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//
//

import UIKit

class DetailViewController: ParentViewController {
    
    //MARK: - User interface element
    
    private var episodesCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<DetailViewSection, Items>?
    private let imageManager = SDWebImageManager.shared
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
    private var characterNameLabel = UILabel(font: UIFont(name: "gilroy-black", size: 22), textAlignment: .center, textColor: .white)
    private var characterStatusLabel = UILabel(font: UIFont(name: "gilroy-regular", size: 18), textAlignment: .center, textColor: .textGreen)
    
    //MARK: - Propertie
    
    var presenter: DetailPresenter!
    
    //MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        
        // Call method's
        presenter.fetchEpisodesData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        // Call method's
        presenter.updateData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        episodesCollectionView.layoutIfNeeded()
        characterImage.layer.cornerRadius = characterImage.frame.size.width / 9
    }
    
    //MARK: - Method
    
    override func setupView() {
        super.setupView()
        
        // Setup view
        view.backgroundColor = .backBlue
        view.addSubviews(characterImage, characterStackView)
       
       // Setup charecter stack view
       characterStackView.addArrangedSubviews(characterNameLabel, characterStatusLabel)

        // Setup navigation bar
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonClick))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItems = [backButton]
       
        // Call method's
        setupCollectionView()
        setupLabels()
    }
    
   override func setupConstraints() {
       super.setupConstraints()
       
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
            
            // Episodes collection view
            episodesCollectionView.topAnchor.constraint(equalTo: characterStackView.bottomAnchor, constant: 15),
            episodesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            episodesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            episodesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
    }
    
    //MARK: - Private method
    
    private func setupLabels() {
        characterNameLabel.adjustsFontSizeToFitWidth = true
        characterNameLabel.minimumScaleFactor = 0.5
        
        characterNameLabel.text = presenter.character.name
        let image = URL(string: presenter.character.image)!
        imageManager.setImageFromUrl(image: characterImage, url: image)
        
        let statusValue = presenter.character.status
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
    }
    
    //MARK: - Objective - C method
    
    @objc func backButtonClick() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extension
//MARK: DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    
    func updateData() {
        DispatchQueue.main.async {
            self.applySnapshot()
            self.presenter.updateData()
        }
    }
}

//MARK: UICollectionViewCompositionalLayout

extension DetailViewController {
    
    // Setup collection view
    private func setupCollectionView() {
        // Setup collection view
        episodesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCompositionalLayout())
        episodesCollectionView.backgroundColor = .clear
        episodesCollectionView.showsVerticalScrollIndicator = false
        configureDataSource()
        view.addSubviews(episodesCollectionView)
    }
    
    // Methods create headers suplimentary view for cell's
    private func setupInfoSupplementaryViewRegistration() -> UICollectionView.SupplementaryRegistration<HeaderForSection> {
        return UICollectionView.SupplementaryRegistration<HeaderForSection>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Info"
            header.titleLabel.textColor = .white
            header.titleLabel.font = UIFont(name: "gilroy-black", size: 17)
        }
    }
    
    private func setupOriginSupplementaryViewRegistration() -> UICollectionView.SupplementaryRegistration<HeaderForSection> {
        return UICollectionView.SupplementaryRegistration<HeaderForSection>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Origin"
            header.titleLabel.textColor = .white
            header.titleLabel.font = UIFont(name: "gilroy-black", size: 17)
        }
    }
    
    private func setupEpisodesSupplementaryViewRegistration() -> UICollectionView.SupplementaryRegistration<HeaderForSection> {
        return UICollectionView.SupplementaryRegistration<HeaderForSection>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Episodes"
            header.titleLabel.textColor = .white
            header.titleLabel.font = UIFont(name: "gilroy-black", size: 17)
        }
    }
    
    // Methods for register cell's
    private func infoRegisterCells() -> UICollectionView.CellRegistration<InfoCollectionViewCell, CharacterResult> {
        return UICollectionView.CellRegistration { (cell, indexPath, item) in
            cell.layoutIfNeeded()
            cell.setupDataForCell(with: item)
        }
    }
    
    private func originRegisterCells() -> UICollectionView.CellRegistration<OriginCollectionViewCell, Location> {
        return UICollectionView.CellRegistration { (cell, indexPath, item) in
            cell.layoutIfNeeded()
            cell.setupDataForCell(with: item)
        }
    }
    
    private func episodesRegisterCell() -> UICollectionView.CellRegistration<EpisodesCollectionViewCell, EpisodeResult> {
        return UICollectionView.CellRegistration { (cell, indexPath, item) in
            cell.layoutIfNeeded()
            cell.setupDataForCell(with: item)
        }
    }
    
    // Create compositional layout
    private func setupCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = DetailViewSection(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            let spacing: CGFloat = 10
            switch sectionKind {
            case .info:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width - 45), heightDimension: .absolute(124))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 20, leading: spacing, bottom: spacing, trailing: -spacing)
                section.interGroupSpacing = 5
                section.contentInsetsReference = .layoutMargins
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                section.boundarySupplementaryItems = [header]
                
                return section
                
            case .origin:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width - 45), heightDimension: .absolute(80))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: -spacing)
                section.interGroupSpacing = 5
                section.contentInsetsReference = .layoutMargins
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                section.boundarySupplementaryItems = [header]
                
                return section
                
            case .episodes:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width - 45), heightDimension: .absolute(86))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
                group.interItemSpacing = .fixed(spacing)
                
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: -spacing)
                section.interGroupSpacing = 5
                section.contentInsetsReference = .layoutMargins
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                section.boundarySupplementaryItems = [header]
                
                return section
            }
        }
    }

    // Configure data source for UICollectionViewCompositionalLayout
    private func configureDataSource() {
        // Cell's
        let infoCell = infoRegisterCells()
        let originCell = originRegisterCells()
        let episodesCell = episodesRegisterCell()
        
        // Header's
        let infoHeader = setupInfoSupplementaryViewRegistration()
        let originHeader = setupOriginSupplementaryViewRegistration()
        let episodesHeader = setupEpisodesSupplementaryViewRegistration()
        
        // Register cell's
        dataSource = UICollectionViewDiffableDataSource<DetailViewSection, Items>(collectionView: episodesCollectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch DetailViewSection(rawValue: indexPath.section)! {
            case .info:
                return collectionView.dequeueConfiguredReusableCell(using: infoCell, for: indexPath, item: item.info)
            case .origin:
                return collectionView.dequeueConfiguredReusableCell(using: originCell, for: indexPath, item: item.origin)
            case .episodes:
                return collectionView.dequeueConfiguredReusableCell(using: episodesCell, for: indexPath, item: item.episodes)
            }
        }
        
        // Register header's
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = DetailViewSection(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .info:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: infoHeader, for: indexPath)
                    case .origin:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: originHeader, for: indexPath)
                    case .episodes:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: episodesHeader, for: indexPath)
                    }
                }
            }
            return nil
        }
    }
    
    // Snapshot for collection
    private func applySnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<DetailViewSection, Items>()
        snapShot.appendSections([.info, .origin, .episodes])
        
        snapShot.appendItems(presenter.info.map { Items(info: $0) }, toSection: .info)
        snapShot.appendItems(presenter.origin.map { Items(origin: $0) }, toSection: .origin)
        snapShot.appendItems(presenter.episodes.map { Items(episodes: $0) }, toSection: .episodes)
        
        dataSource?.apply(snapShot)
    }
}
