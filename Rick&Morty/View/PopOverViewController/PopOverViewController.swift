//
//  PopOverViewController.swift
//  Rick&Morty
//
//  Created by Nikita on 29.03.2024.
//

import UIKit

class PopOverViewController: ParentViewController {
    
    //MARK: - Properties
    
    let imageForRow = ["person.fill", "film", "globe"]
    let textForRow = ["Characters", "Episodes", "Origins"]
    
    //MARK: - User interface elements
    
    let popOverTableView = PopOverTableView()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        signatureDelegates()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        popOverTableView.layoutIfNeeded()
    }
    
    //MARK: - Method
    
    func signatureDelegates() {
        popOverTableView.delegate = self
        popOverTableView.dataSource = self
    }
    
    override func setupView() {
        super.setupView()
        view.addSubviews(popOverTableView)
        
        // Setup table
        popOverTableView.register(PopOverTableCell.self, forCellReuseIdentifier: PopOverTableCell.reuseID)
        popOverTableView.showsVerticalScrollIndicator = false
        popOverTableView.isScrollEnabled = false
        popOverTableView.separatorColor = .lightGray
        popOverTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        popOverTableView.backgroundColor = .viewBackGray
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            // Pop over table
            popOverTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            popOverTableView.widthAnchor.constraint(equalToConstant: 200),
            popOverTableView.heightAnchor.constraint(equalToConstant: 110),
            popOverTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension PopOverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popOverTableView.dequeueReusableCell(withIdentifier: PopOverTableCell.reuseID, for: indexPath) as! PopOverTableCell
        cell.titleLabel.text = textForRow[indexPath.row]
        cell.iconImage.image = UIImage(systemName: imageForRow[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 35
        return heightRow
    }
}
