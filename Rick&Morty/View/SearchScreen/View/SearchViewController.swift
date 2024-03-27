//
//  SearchViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: SearchPresenter!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .textGreen
    }
}

extension SearchViewController: SearchViewProtocol {
    
    func updateData() {
        print("update data")
    }
}
