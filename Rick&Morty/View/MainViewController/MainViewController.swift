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
    
    private var characters = [Item(personImage: "test", name: "Test Test")]
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupCollectionView()
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
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributed
        navigationController?.navigationBar.titleTextAttributes = titleAttributed
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    /// Setup collection view
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Create collection view layout
    private func createViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = MainViewSection(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
            case .section:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(156), heightDimension: .absolute(202))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let  groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(105))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
                return section
            }
        }
    }
    
    /// Data source for collection view
    private func collectionViewDataSource() {
        
    }
}


//MARK: - Extension

extension MainViewController: UICollectionViewDelegate {
    
}
