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
    func updateData()
}

final class MainPresenter: MainPresenterProtocol {
    
    //MARK: - Propertie
    
    weak var view: MainViewProtocol!
    let networkManager = NetworkManager()
    var characters = [
        Characters(characterName: "Rick Sanchez", characterImage: "rick"),
        Characters(characterName: "Morty", characterImage: "rick"),
        Characters(characterName: "Nikita", characterImage: "rick"),
        Characters(characterName: "Dima", characterImage: "rick"),
        Characters(characterName: "Roma", characterImage: "rick"),
        Characters(characterName: "Din", characterImage: "rick"),
        Characters(characterName: "Sam", characterImage: "rick"),
        Characters(characterName: "Nick", characterImage: "rick"),
        Characters(characterName: "Bob", characterImage: "rick"),
        Characters(characterName: "Gilroy", characterImage: "rick")
    ]
 
    //MARK: - Initialize
    
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    //MARK: - Method
    
    func updateData() {
        self.view.updateData()
    }
}
