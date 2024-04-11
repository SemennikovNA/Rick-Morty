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
        view.backgroundColor = .clear
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
    private let activityIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .white
        return activityIndicator
    }()
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
        
        // Activity indicator view
        activityIndicatorView.addSubviews(activityIndicator)
        
        // Text field settings
        searchTextField.leftViewMode = .always
        searchTextField.leftView = dropMenuView
        searchTextField.rightViewMode = .always
        searchTextField.rightView = activityIndicatorView
        
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
            
            // Activity indicator view
            activityIndicatorView.topAnchor.constraint(equalTo: searchTextField.rightView!.topAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: searchTextField.rightView!.trailingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: searchTextField.rightView!.bottomAnchor),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 50),
            
            // Activity indicator
            activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor),
            
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

//MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {

    func updateData() {
        DispatchQueue.main.async {
            self.applySnapshot()
            self.presenter.updateData()
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
            cell.setupDataForCell(with: result)
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func episodeRegisterCells() -> UICollectionView.CellRegistration<EpisodesCollectionViewCell, EpisodeResult> {
        return UICollectionView.CellRegistration<EpisodesCollectionViewCell, EpisodeResult> { (cell, indexPath, episode) in
            cell.layoutIfNeeded()
            cell.setupDataForCell(with: episode)
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func originRegisterCells() -> UICollectionView.CellRegistration<OriginCollectionViewCell, Location> {
        return UICollectionView.CellRegistration<OriginCollectionViewCell, Location> { (cell, indexPath, origin) in
            cell.layoutIfNeeded()
            cell.setupDataForCell(with: origin)
            self.activityIndicator.stopAnimating()
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
                    widthDimension: .absolute(UIScreen.main.bounds.width - 30),
                    heightDimension: .absolute(150))
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
                    widthDimension: .absolute(UIScreen.main.bounds.width - 30),
                    heightDimension: .absolute(90))
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
                    widthDimension: .absolute(UIScreen.main.bounds.width - 30),
                    heightDimension: .absolute(110))
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
        
        dataSource = UICollectionViewDiffableDataSource<SearchViewSection, Items>(collectionView: searchCollectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch SearchViewSection(rawValue: indexPath.section)! {
            
            case .character:
                return self.searchCollectionView.dequeueConfiguredReusableCell(using: characterCell, for: indexPath, item: item.info)
            case .episode:
                return self.searchCollectionView.dequeueConfiguredReusableCell(using: episodeCell, for: indexPath, item: item.episodes)
            case .location:
                return self.searchCollectionView.dequeueConfiguredReusableCell(using: originCell, for: indexPath, item: item.origin)
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
        
        DispatchQueue.main.async {
            self.dataSource?.apply(snapShot)
        }
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if let text = textField.text {
            self.activityIndicator.startAnimating()
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
