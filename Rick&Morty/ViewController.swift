//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 29.02.2024.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - User interface elements
    
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
    }

    //MARK: - Private method
    
    private func setupView() {
        // Setup view
        view.backgroundColor = .backBlue
        
        // Setup navigation bar
        navigationItem.title = "Characters"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
