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
    
    init(view: DetailViewProtocol)
    var info: [InfoModel] { get set }
    var origin: [OriginModel] { get set }
    var episodes: [EpisodesModel] { get set }
    func updateData()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    //MARK: - Propertie
    
    weak var view: DetailViewProtocol!
    let networkManager = NetworkManager()
    
    var info: [InfoModel] = [
        InfoModel(species: "Human", type: "None", gender: "Male")
    ]
    var origin: [OriginModel] = [
        OriginModel(planetName: "Earth", imageName: "")
    ]
    var episodes: [EpisodesModel] = [
        EpisodesModel(episodesName: "Pilot", episodesSeasonNumber: "Episode: 1, Season: 1", episodesDate: "December 2, 2013"),
        EpisodesModel(episodesName: "Lawnmower Dog", episodesSeasonNumber: "Episode: 2, Season: 1", episodesDate: "December 9, 2013"),
        EpisodesModel(episodesName: "Anatomy Park", episodesSeasonNumber: "Episode: 3, Season: 1", episodesDate: "December 16, 2013")
    ]
    
    
    //MARK: - Initialize
    
    init(view: DetailViewProtocol) {
        self.view = view
    }
    
    //MARK: - Method
    
    func updateData() {
        self.view.updateData()
    }
}
