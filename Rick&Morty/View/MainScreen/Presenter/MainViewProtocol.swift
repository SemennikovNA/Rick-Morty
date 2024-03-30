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
    var characters: [Characters] { get set }
    func fetchData()
    func updateData()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkManager = NetworkManager()
    var characters: [Characters] = []

    init(view: MainViewProtocol) {
        self.view = view
        
        self.networkManager.delegate = self
    }
    
    func fetchData() {
        networkManager.fetchData(url: URLBuilder.character.request)
    }

    func updateData() {
        self.view?.updateData()
    }
}

extension MainPresenter: LoadedInformation {
    
    func transitData(_ networkManager: NetworkManager, data: [Characters]) {
        DispatchQueue.main.async {
            self.characters.append(contentsOf: data)
            self.updateData()
         }
    }
}
