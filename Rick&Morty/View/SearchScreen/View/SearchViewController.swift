//
//  SearchViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import UIKit

final class SearchViewController: ParentViewController {

    //MARK: - Properties

    private let popOverVC = PopOverViewController()
    var presenter: SearchPresenter!
    private var titleText = "Character"
    private var dataSource: UICollectionViewDiffableDataSource<SearchViewSection, Items>?
    
    //MARK: - User interface elements
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter something"
        textField.tintColor = .white
        textField.textColor = .white
        textField.keyboardType = .webSearch
        textField.backgroundColor = .cellBackBlue
        return textField
    }()
    private let dropMenuView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    private let dropMenuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "gilroy-black", size: 15)
        return label
    }()
    private let dropViewGestureRecognize = UITapGestureRecognizer()
    private var searchCollectionView: UICollectionView!
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        signatureDelegate()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        searchTextField.layer.cornerRadius = searchTextField.frame.width / 30
        searchTextField.clipsToBounds = true
    }

    //MARK: - Method

    override func setupView() {
        super.setupView()
        setupCollectionView()
        
        // Screen settings
        view.backgroundColor = .backBlue
        view.addSubviews(searchTextField, searchCollectionView)
        
        // Text field settings
        searchTextField.leftViewMode = .always
        searchTextField.leftView = dropMenuView
        
        // Drop menu view
        dropMenuView.addSubviews(dropMenuLabel)
        dropMenuView.addGestureRecognizer(dropViewGestureRecognize)
        
        // Drop menu title
        dropMenuLabel.text = titleText
        
        // Drop view gesture recognize
        dropViewGestureRecognize.view?.frame = dropMenuView.bounds
        dropViewGestureRecognize.addTarget(self, action: #selector(tapDropMenuButton))
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
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
            // Search text field
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Drop menu view
            dropMenuView.topAnchor.constraint(equalTo: searchTextField.leftView!.topAnchor),
            dropMenuView.leadingAnchor.constraint(equalTo: searchTextField.leftView!.leadingAnchor),
            dropMenuView.bottomAnchor.constraint(equalTo: searchTextField.leftView!.bottomAnchor),
            dropMenuView.widthAnchor.constraint(equalToConstant: 100),
            
            // Drop menu title
            dropMenuLabel.topAnchor.constraint(equalTo: dropMenuView.topAnchor),
            dropMenuLabel.leadingAnchor.constraint(equalTo: dropMenuView.leadingAnchor),
            dropMenuLabel.trailingAnchor.constraint(equalTo: dropMenuView.trailingAnchor),
            dropMenuLabel.bottomAnchor.constraint(equalTo: dropMenuView.bottomAnchor),
            
            // Search collection view
            searchCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - Private method
    
    private func signatureDelegate() {
        searchTextField.delegate = self
        searchCollectionView.delegate = self
    }
    
    func setTitleForChoiseButton(title: String) {
        self.titleText = title
        self.dropMenuLabel.text = title
        self.dismiss(animated: true, completion: nil)
        print(titleText)
    }

    //MARK: - Objective - C method

    @objc func tapDropMenuButton() {
        popOverVC.modalPresentationStyle = .popover
        popOverVC.preferredContentSize = CGSize(width: 220, height: 115)

        guard let presentationVC = popOverVC.popoverPresentationController else { return }
        presentationVC.delegate = self
        presentationVC.permittedArrowDirections = .up
        presentationVC.sourceView = dropMenuView
        presentationVC.sourceRect = CGRect(x: searchTextField.bounds.minX + 25,
                                           y: searchTextField.bounds.maxY - 10,
                                           width: 0,
                                           height: 0)
        DispatchQueue.main.async { [self] in
            self.present(self.popOverVC, animated: true)
            popOverVC.didSelectOption = { [weak self] title in
                self?.setTitleForChoiseButton(title: title)
            }
        }
    }
}

//MARK: - UICollectionViewCompositionalLayout

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /// Setup collection view
    private func setupCollectionView() {
        searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCompositionalLayout())
        searchCollectionView.backgroundColor = .clear
        searchCollectionView.showsVerticalScrollIndicator = false
        configureDataSource()
    }
    
    // Method's for register cell's
    private func characterRegisterCells() -> UICollectionView.CellRegistration<SearchCollectionViewCell, CharacterResult> {
        return UICollectionView.CellRegistration<SearchCollectionViewCell, CharacterResult> { (cell, indexPath, result) in
            cell.layoutIfNeeded()
        }
    }
    
    private func episodeRegisterCells() -> UICollectionView.CellRegistration<EpisodesCollectionViewCell, EpisodeResult> {
        return UICollectionView.CellRegistration<EpisodesCollectionViewCell, EpisodeResult> { (cell, indexPath, episode) in
            cell.layoutIfNeeded()
        }
    }
    
    private func originRegisterCells() -> UICollectionView.CellRegistration<OriginCollectionViewCell, Location> {
        return UICollectionView.CellRegistration<OriginCollectionViewCell, Location> { (cell, indexPath, origin) in
            cell.layoutIfNeeded()
        }
    }
    
    /// Setup layout
    private func setupCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = SearchViewSection(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            let spacing: CGFloat = 10
            
            switch sectionKind {
            case .character:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.515),
                    heightDimension: .absolute(160))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 1)
                group.interItemSpacing = .fixed(spacing)
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                section.interGroupSpacing = spacing
                section.contentInsetsReference = .layoutMargins
                return section
            case .location:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.515),
                    heightDimension: .absolute(160))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 1)
                group.interItemSpacing = .fixed(spacing)
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                section.interGroupSpacing = spacing
                section.contentInsetsReference = .layoutMargins
                return section
            case .episode:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.515),
                    heightDimension: .absolute(160))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 1)
                group.interItemSpacing = .fixed(spacing)
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
                section.interGroupSpacing = spacing
                section.contentInsetsReference = .layoutMargins
                return section
            }
        }
    }
    
    private func configureDataSource() {
        
        let characterCell = characterRegisterCells()
        let episodeCell = episodeRegisterCells()
        let originCell = originRegisterCells()
        
        dataSource = UICollectionViewDiffableDataSource<SearchViewSection, Items>(collectionView: searchCollectionView) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch SearchViewSection(rawValue: indexPath.section)! {
            
            case .character:
                return self?.searchCollectionView.dequeueConfiguredReusableCell(using: characterCell, for: indexPath, item: item.info)
            case .episode:
                return self?.searchCollectionView.dequeueConfiguredReusableCell(using: episodeCell, for: indexPath, item: item.episodes)
            case .location:
                return self?.searchCollectionView.dequeueConfiguredReusableCell(using: originCell, for: indexPath, item: item.origin)
            }
        }
    }
    
    // Snapshot for collection
    private func applySnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<SearchViewSection, Items>()
        snapShot.appendSections([.character, .location, .episode])
        
        snapShot.appendItems(presenter.character.map { Items(info: $0) }, toSection: .character)
        snapShot.appendItems(presenter.location.map { Items(origin: $0) }, toSection: .location)
        snapShot.appendItems(presenter.episode.map { Items(episodes: $0) }, toSection: .episode)
        
        dataSource?.apply(snapShot)
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if let text = textField.text {
            presenter.searchData(text, flag: self.titleText)
        }
        textField.text = ""
        return true
    }
}

//MARK: - UIPopoverPresentationControllerDelegate

extension SearchViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        .none
    }
}

//MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {

    func updateData() {
        print("update data")
    }
}
