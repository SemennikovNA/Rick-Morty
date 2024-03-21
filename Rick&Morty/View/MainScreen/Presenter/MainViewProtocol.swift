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
    func fetchData()
    func updateData()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkManager = NetworkManager()
    var characters: [Charac] = []

    init(view: MainViewProtocol) {
        self.view = view
    }
    
    func fetchData() {
        self.networkManager.delegate = self
        networkManager.fetchData()
    }

    func updateData() {
        self.view?.updateData()
    }
}

extension MainPresenter: LoadedInformation {
    
    func transitData(_ networkManager: NetworkManager, data: [Charac]) {
        DispatchQueue.main.async { [weak self] in
             self?.characters = data
             self?.updateData()
         }
    }
}
