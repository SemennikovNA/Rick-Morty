//
//  SearchViewProtocol.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    
    func updateData()
}

protocol SearchPresenterProtocol: AnyObject {
    
    init(view: SearchViewProtocol)
    func updateData()
}

final class SearchPresenter: SearchPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: SearchViewProtocol?
    
    //MARK: - Initialization
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    //MARK: - Methods
    
    func updateData() {
        
    }
}
