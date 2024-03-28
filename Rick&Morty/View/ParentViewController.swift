//
//  ParentViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 28.03.2024.
//

import UIKit

class ParentViewController: UIViewController {
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Call method's
        setupView()
        setupNavigationBar()
        setupConstraints()
    }
    
    //MARK: - Methods
    
    func setupView() { }
    
    func setupNavigationBar() {}
    
    func signatureDelegates () {}
    
    func setupConstraints() {}
}
