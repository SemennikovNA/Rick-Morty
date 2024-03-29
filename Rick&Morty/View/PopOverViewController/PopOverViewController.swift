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
    var didSelectOption: ((String) -> Void)?
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackGray
        
        // Call method's
        signatureDelegates()
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
            popOverTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            popOverTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popOverTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popOverTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PopOverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textForRow.count
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PopOverTableCell else { return }
        guard let labelText = cell.titleLabel.text else {
            print("Label text equal nil")
            return
        }
        didSelectOption?(labelText)
    }
}
