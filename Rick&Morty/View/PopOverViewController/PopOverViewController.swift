//
//  PopOverViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 29.03.2024.
//

import UIKit

class PopOverViewController: UIViewController {
    
    //MARK: - User interface elements
    
    let popOverTableView = PopOverTableView()
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        signatureDelegates()
        setupConstraints()
    }
    
    //MARK: - Method
    
    func signatureDelegates() {
        popOverTableView.delegate = self
        popOverTableView.dataSource = self
    }
    
    func setupView() {
        view.addSubviews(popOverTableView)
        
        // Setup table
        popOverTableView.register(PopOverTableCell.self, forCellReuseIdentifier: PopOverTableCell.reuseID)
        popOverTableView.separatorColor = .white
        popOverTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        popOverTableView.backgroundColor = .viewBackGray
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Pop over table
            popOverTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            popOverTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            popOverTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            popOverTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
    }
}

extension PopOverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popOverTableView.dequeueReusableCell(withIdentifier: PopOverTableCell.reuseID, for: indexPath) as! PopOverTableCell
        cell.titleLabel.text = "Строка \(indexPath.row)"
        cell.iconImage.image = UIImage(systemName: "person.fill")
        return cell
    }
}
