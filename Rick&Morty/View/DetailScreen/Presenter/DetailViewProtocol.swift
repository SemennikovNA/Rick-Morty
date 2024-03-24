//
//  DetailViewProtocol.swift
//  Rick&Morty
//
//  Created by Nikita on 04.03.2024.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    
    func updateData()
}

protocol DetailPresenterProtocol: AnyObject {
    
    init(view: DetailViewProtocol, data: Results)
    var data: Results { get set }
    var info: [InfoModel] { get set }
    var origin: [OriginModel] { get set }
    var episodes: [EpisodesModel] { get set }
    func updateData()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    
    //MARK: - Properties
    
    weak var view: DetailViewProtocol?
    let networkManager = NetworkManager()
    var data: Results
    var info: [InfoModel] = []
    var origin: [OriginModel] = []
    var episodes: [EpisodesModel] = []
    
    //MARK: - Initialization
    
    init(view: DetailViewProtocol, data: Results) {
        self.view = view
        self.data = data
        
        let species = data.species.rawValue
        let type = data.type
        let gender = data.gender.rawValue
        let originName = data.origin.name
        let originURL = data.origin.url
        let infoModel = InfoModel(species: species, type: type, gender: gender)
        
        self.info.removeAll()
        self.info = [infoModel]
        
        // TODO: - Здесь установить инфу в массив origin, сначала нужно очистить массив
//      Присваиваем значение data.origin свойству origin
        self.origin.removeAll()
        self.origin = [OriginModel(planetName: originName, imageName: originURL)]
        
        // TODO: - Здесь установить инфу в массив episodes, сначала нужно очистить массив
//        let episodeName = data
//        self.episodes.removeAll()
    }
    
    //MARK: - Methods
    
    func updateData() {

        self.view?.updateData()
    }
}

