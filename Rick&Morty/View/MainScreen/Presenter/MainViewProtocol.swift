//
//  MainViewProtocol.swift
//  Rick&Morty
//
//  Created by Nikita on 04.03.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    
    func updateData()
}

protocol MainPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol)
    var characters: [Charac] { get set }
    func updateData()
}

final class MainPresenter: MainPresenterProtocol {
    
    //MARK: - Propertie
    
    weak var view: MainViewProtocol!
    let networkManager = NetworkManager()
    var characters: [Charac] = []
 
    //MARK: - Initialize
    
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    //MARK: - Method
    
    func updateData() {
        self.view.updateData()
    }
}
