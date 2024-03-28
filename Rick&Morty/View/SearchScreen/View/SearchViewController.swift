//
//  SearchViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import UIKit

class SearchViewController: ParentViewController {
    
    //MARK: - Properties
    
    var presenter: SearchPresenter!
    
    //MARK: - User interface elements
    
    private let searchTextField = CustomTextField()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        searchTextField.layoutIfNeeded()
    }
    
    //MARK: - Method
    
    override func setupView() {
        super.setupView()
        
        // Screen settings
        view.backgroundColor = .backBlue
        view.addSubviews(searchTextField)
    }
    
    override func signatureDelegates() {
        super.signatureDelegates()
        
        searchTextField.searchTextField.delegate = self
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
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

//MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    
    func updateData() {
        print("update data")
    }
}
