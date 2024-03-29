//
//  PopOverTableView.swift
//  Rick&Morty
//
//  Created by Nikita on 29.03.2024.
//

import UIKit

class PopOverTableView: UITableView {
    
    //MARK: - Initialize
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        self.layer.cornerRadius = self.frame.size.width / 15
        self.clipsToBounds = true
    }
}
