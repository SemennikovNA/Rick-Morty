//
//  MainViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 29.02.2024.
//

import UIKit

class MainViewController: ParentViewController {
    
    //MARK: - User interface elements
    
    private var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private let networkManager = NetworkManager.shared
    private var dataSource: UICollectionViewDiffableDataSource<MainViewSection, CharacterResult>?
    var presenter: MainPresenter!
    var currentPage = 1
    var characterList = [CharacterResult]()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        presenter.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Method
    /// Setup view
    override func setupView() {
        super.setupView()
        
        // Setup view
        view.backgroundColor = .backBlue
        
        // Call method's
        setupCollectionView()
    }
    
    /// Setup navigation bar
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
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
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - Private method
    
    private func loadMoreData() {
        currentPage += 1
        presenter.loadMoreData(pageNumber: self.currentPage)
    }
}


//MARK: - Extension

//MARK: MainPresenterProtocol

extension MainViewController: MainViewProtocol {
    
    func updateData() {
        applySnapshot()
        collectionView.reloadData()
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
    
    // Method for register cell
    private func charactersRegisterCells() -> UICollectionView.CellRegistration<CharactersCollectionViewCell, CharacterResult> {
        return UICollectionView.CellRegistration<CharactersCollectionViewCell, CharacterResult> { (cell, indexPath, result) in
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
        
        dataSource = UICollectionViewDiffableDataSource<MainViewSection, CharacterResult>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch MainViewSection(rawValue: indexPath.section)! {
            case .section:
                return collectionView.dequeueConfiguredReusableCell(using: characterCell, for: indexPath, item: item)
            }
        }
    }
    
    // Snapshot for collection
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MainViewSection, CharacterResult>()
        snapshot.appendSections([.section])
        
        let characterData = presenter.characters
        self.characterList = characterData
        snapshot.appendItems(characterData, toSection: .section)
        
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot)
        }
    }
    
    // Setup did select item at
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = self.dataSource?.itemIdentifier(for: indexPath) else {
            print("selectedItem equals nil")
            return
        }
        let info = CharacterResult(id: selectedItem.id, name: selectedItem.name, status: selectedItem.status, species: selectedItem.species, type: selectedItem.type, gender: selectedItem.gender, origin: selectedItem.origin, location: selectedItem.location, image: selectedItem.image, episode: selectedItem.episode, url: selectedItem.url)
        let detailView = Builder.createDetailView(character: info)
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == characterList.count - 8 else { return }
        DispatchQueue.main.async {
            self.loadMoreData()
        }
    }
}
