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
    private var dataSource: UICollectionViewDiffableDataSource<MainViewSection, Charac>?
    var presenter: MainPresenter!
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupNavigationBar()
        setupView()
        setupConstraints()
        presenter.fetchData()
        presenter.updateData()
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
}


//MARK: - Extension

//MARK: MainPresenterProtocol

extension MainViewController: MainViewProtocol {
    
    func updateData() {
        DispatchQueue.main.async {
            self.applySnapshot()
            self.collectionView.reloadData()
        }
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
    private func charactersRegisterCells() -> UICollectionView.CellRegistration<CharactersCollectionViewCell, Charac> {
        return UICollectionView.CellRegistration<CharactersCollectionViewCell, Charac> { [self] (cell, indexPath, item) in
            cell.layoutIfNeeded()
            let data = presenter.characters[indexPath.item]
            let dataForCell = data.results[indexPath.item]
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
        
        dataSource = UICollectionViewDiffableDataSource<MainViewSection, Charac>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch MainViewSection(rawValue: indexPath.section)! {
            case .section:
                return collectionView.dequeueConfiguredReusableCell(using: characterCell, for: indexPath, item: item)
            }
        }
    }

    
    // Snapshot for collection
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MainViewSection, Charac>()
        snapshot.appendSections([.section])

        let characterData = presenter.characters
        snapshot.appendItems(characterData, toSection: .section)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot)
        }
    }
    
    // Setup did select item at
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = Builder.createDetailView()
        navigationController?.pushViewController(detailVC, animated: true)
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
