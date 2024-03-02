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

    private var dataSource: UICollectionViewDiffableDataSource<MainViewSection, Item>?
    private var characters = [
        Item(characterImage: "test", characterName: "Rick"),
        Item(characterImage: "test", characterName: "Morty"),
        Item(characterImage: "test", characterName: "Ainur"),
        Item(characterImage: "test", characterName: "Nikita"),
        Item(characterImage: "test", characterName: "Nikit"),
        Item(characterImage: "test", characterName: "Niki"),
        Item(characterImage: "test", characterName: "Nik"),
        Item(characterImage: "test", characterName: "Ni"),
        Item(characterImage: "test", characterName: "N"),
        Item(characterImage: "test", characterName: "Nk"),
    ]
    private let networkManager = NetworkManager.shared
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupCollectionView()
        configureDataSource()
        networkManager.fetchData { result in
            print(result)
        }
    }
    
    //MARK: - Private method
    /// Setup view
    private func setupView() {
        // Setup view
        view.backgroundColor = .backBlue

        // Call method's
        setupNavigationBar()
    }

    /// Setup navigation bar
    private func setupNavigationBar() {
        // Setup navigation bar
        navigationItem.title = "Characters"
        let titleAttributed: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "gilroy-black", size: 29) ?? .boldSystemFont(ofSize: 29)
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributed
        navigationController?.navigationBar.titleTextAttributes = titleAttributed
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    /// Setup collection view
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
        collectionView.backgroundColor = .clear
        view.addSubviews(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    /// Setup compositional layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.515),
            heightDimension: .absolute(210))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
           section.interGroupSpacing = spacing
        section.contentInsetsReference = .automatic
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return  layout
    }
        
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MainViewSection, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as! CollectionViewCell
            cell.layoutIfNeeded()
            cell.setupDataForCell(with: item)
            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<MainViewSection, Item>()
        snapshot.appendSections([.section])
        snapshot.appendItems(characters)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
