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

    
    
    //MARK: - Propertie
    
    weak var view: DetailViewProtocol!
    let networkManager = NetworkManager()
    var data: Results
    var info: [InfoModel] = []
    var origin: [OriginModel] = []
    var episodes: [EpisodesModel] = []
    
    
    
    //MARK: - Initialize
    
    init(view: DetailViewProtocol, data: Results) {
        self.view = view
        self.data = data
//        self.info = InfoModel(species: "", type: "", gender: "")
//        self.origin = OriginModel(planetName: "", imageName: "")
//        self.episodes = EpisodesModel(episodesName: "", episodesSeasonNumber: "", episodesDate: "")
    }
    
    //MARK: - Method
    
    func updateData() {
//        let species = data.species.rawValue
//        let type = data.type
//        let gender = data.gender.rawValue
//        self.info = InfoModel(species: species, type: type, gender: gender)
//        let origin = data.origin
        self.view.updateData()
    }
}
