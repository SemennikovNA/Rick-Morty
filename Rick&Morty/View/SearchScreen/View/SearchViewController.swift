//
//  SearchViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import UIKit

final class SearchViewController: ParentViewController {

    //MARK: - Properties

    let popOverVC = PopOverViewController()
    var presenter: SearchPresenter!
    var titleText = "Character"

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

    private let cells = SearchCollectionViewCell()
    
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
        cells.layoutIfNeeded()
    }

    //MARK: - Method

    override func setupView() {
        super.setupView()

        // Screen settings
        view.backgroundColor = .backBlue
        view.addSubviews(searchTextField, cells)
        
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
            
            cells.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 50),
            cells.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cells.heightAnchor.constraint(equalToConstant: 130),
            cells.widthAnchor.constraint(equalToConstant: 360),
        ])
    }
    
    //MARK: - Private method
    
    private func signatureDelegate() {
        searchTextField.delegate = self
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
