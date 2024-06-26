//
//  EpisodesCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Nikita on 03.03.2024.
//

import UIKit

class EpisodesCollectionViewCell: ParentCollectionCell {
    
    //MARK: - Propertie
    
    static let id = "EpisodesCell"
    
    //MARK: - User interface element
    
    private let contentCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .viewBackGray
        return view
    }()
    private var episodeName = UILabel(font: UIFont(name: "gilroy-black", size: 17), textAlignment: .left, textColor: .white)
    private var episodeNumber = UILabel(font: UIFont(name: "gilroy-regular", size: 13), textAlignment: .left, textColor: .textGreen)
    private var episodeDate = UILabel(font: UIFont(name: "gilroy-regular", size: 12), textAlignment: .right, textColor: .lightGray)
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.size.width / 20
        self.clipsToBounds = true
    }
    
    //MARK: - Method
    
    func setupDataForCell(with model: EpisodeResult) {
        episodeName.text = model.name
        episodeNumber.text = model.episode
        episodeDate.text = model.airDate
    }
    
    //MARK: - Method
    
    override func setupCellUI() {
        super.setupCellUI()
        self.addSubviews(contentCellView)
        contentCellView.addSubviews(episodeName, episodeNumber, episodeDate)
        
        // Setup label's
        episodeName.adjustsFontSizeToFitWidth = true
        episodeName.minimumScaleFactor = 0.7
    }

    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            // Content cell view
            contentCellView.topAnchor.constraint(equalTo: self.topAnchor),
            contentCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Episode name
            episodeName.topAnchor.constraint(equalTo: contentCellView.topAnchor, constant: 10),
            episodeName.leadingAnchor.constraint(equalTo: contentCellView.leadingAnchor, constant: 10),
            episodeName.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor, constant: -10),
            episodeName.heightAnchor.constraint(equalToConstant: 30),
            
            // Episode nubmer
            episodeNumber.leadingAnchor.constraint(equalTo: contentCellView.leadingAnchor, constant: 10),
            episodeNumber.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor, constant: -10),
            episodeNumber.heightAnchor.constraint(equalToConstant: 30),
            
            // Episode date
            episodeDate.trailingAnchor.constraint(equalTo: contentCellView.trailingAnchor, constant: -10),
            episodeDate.bottomAnchor.constraint(equalTo: contentCellView.bottomAnchor, constant: -10),
            episodeDate.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
