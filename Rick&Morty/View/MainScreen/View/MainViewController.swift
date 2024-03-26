//
//  MainViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 29.02.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - User interface elements
    
    private var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private let networkManager = NetworkManager.shared
    private var dataSource: UICollectionViewDiffableDataSource<MainViewSection, Results>?
    var presenter: MainPresenter!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupNavigationBar()
        setupView()
        setupConstraints()
        presenter.fetchData()
    }
    
    //MARK: - Private method
    /// Setup view
    private func setupView() {
        // Setup view
        view.backgroundColor = .backBlue
        
        // Call method's
        setupCollectionView()
    }
    
    /// Setup navigation bar
    private func setupNavigationBar() {
        // Setup navigation item title
        self.navigationItem.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        let titleAttributed: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "gilroy-black", size: 29) as Any,
            .foregroundColor: UIColor.white
        ]
        
        // Setup navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = titleAttributed
        appearance.largeTitleTextAttributes = titleAttributed
        appearance.backgroundColor = .backBlue
        self.navigationController?.navigationBar.standardAppearance = appearance
    }
}


//MARK: - Extension

//MARK: MainPresenterProtocol

extension MainViewController: MainViewProtocol {
    
    func updateData() {
        applySnapshot()
    }
}

//MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    /// Setup collection view
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCompositionalLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        configureDataSource()
        view.addSubviews(collectionView)
    }
    
    // Method for register cell's
    private func charactersRegisterCells() -> UICollectionView.CellRegistration<CharactersCollectionViewCell, Results> {
        return UICollectionView.CellRegistration<CharactersCollectionViewCell, Results> { (cell, indexPath, result) in
            cell.layoutIfNeeded()
            let dataForCell = result
            cell.setupDataForCell(with: dataForCell)
        }
    }
    
    // Create compositional layout
    private func setupCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = MainViewSection(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            let spacing: CGFloat = 10
            
            switch sectionKind {
            case .section:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.515),
                    heightDimension: .absolute(210))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                group.interItemSpacing = .fixed(spacing)
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                section.interGroupSpacing = spacing
                section.contentInsetsReference = .layoutMargins
                return section
            }
        }
    }
    
    // Configure data source for UICollectionViewCompositionalLayout
    private func configureDataSource() {
        // Cell
        let characterCell = charactersRegisterCells()
        
        dataSource = UICollectionViewDiffableDataSource<MainViewSection, Results>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch MainViewSection(rawValue: indexPath.section)! {
            case .section:
                return collectionView.dequeueConfiguredReusableCell(using: characterCell, for: indexPath, item: item)
            }
        }
    }
    
    // Snapshot for collection
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MainViewSection, Results>()
        snapshot.appendSections([.section])
        
        let characterData = presenter.characters.map({ $0.results }).flatMap({ $0 })
        snapshot.appendItems(characterData, toSection: .section)
        
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot)
        }
    }
    
    // Setup did select item at
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = self.dataSource?.itemIdentifier(for: indexPath) {
            let type = selectedItem.type
            let species = selectedItem.species.rawValue
            let gender = selectedItem.gender.rawValue
            let info = InfoModel(species: species, type: type, gender: gender)
            
            let originName = selectedItem.origin.name
            let originUrl = selectedItem.origin.url
            let origin = OriginModel(planetName: originName, imageName: originUrl)
            
            let episodes = selectedItem.episode
            
            let detailView = Builder.createDetailView(character: selectedItem, info: info, origin: origin, episodes: episodes)
            navigationController?.pushViewController(detailView, animated: true)
        } else {
            print("Ошибка: данные для selectedItem отсутствуют")
        }
    }
}

//MARK: - Private extension
//MARK: Constraints
private extension MainViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
