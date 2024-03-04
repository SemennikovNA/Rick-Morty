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
        Item(characterImage: "rick", characterName: "Rick Sanchez"),
        Item(characterImage: "rick", characterName: "Morty"),
        Item(characterImage: "rick", characterName: "Nikita"),
        Item(characterImage: "rick", characterName: "Dima"),
        Item(characterImage: "rick", characterName: "Roma"),
        Item(characterImage: "rick", characterName: "Din"),
        Item(characterImage: "rick", characterName: "Sam"),
        Item(characterImage: "rick", characterName: "Nick"),
        Item(characterImage: "rick", characterName: "Bob"),
        Item(characterImage: "rick", characterName: "Gilroy"),
    ]
    private let networkManager = NetworkManager.shared
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupNavigationBar()
        setupView()
        setupCollectionView()
        configureDataSource()
//        networkManager.fetchData { result in
//            print(result)
//        }
    }
    
    //MARK: - Private method
    /// Setup view
    private func setupView() {
        // Setup view
        view.backgroundColor = .backBlue
    }

    /// Setup navigation bar
    private func setupNavigationBar() {
        // Setup navigation item title
        navigationItem.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        let titleAttributed: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "gilroy-black", size: 29) as Any,
            .foregroundColor: UIColor.white
        ]
        
        // Setup navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = titleAttributed
        appearance.largeTitleTextAttributes = titleAttributed
        appearance.backgroundColor = .backBlue
        navigationController?.navigationBar.standardAppearance = appearance
    }


    /// Setup collection view
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.id)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
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

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.id, for: indexPath) as! CharactersCollectionViewCell
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


//MARK: - Extension

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = Builder.createDetailView()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
