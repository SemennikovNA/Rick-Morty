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
    
    init(view: DetailViewProtocol, character: Results, info: InfoModel, origin: OriginModel, episodes: [String])
    var character: Results { get set }
    var info: [InfoModel] { get set }
    var origin: [OriginModel] { get set }
    var episodes: [Episodes] { get set }
    func updateData()
    func fetchEpisodesData()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: DetailViewProtocol?
    let networkManager = NetworkManager()
    var character: Results
    var info: [InfoModel] = []
    var origin: [OriginModel] = []
    var episodes: [Episodes] = []
    
    //MARK: - Initialization
    
    init(view: DetailViewProtocol, character: Results, info: InfoModel, origin: OriginModel, episodes: [String]) {
        self.view = view
        
        self.info.removeAll()
        self.origin.removeAll()
        self.info = [info]
        self.origin = [origin]
        self.character = character
        self.episodes.removeAll()
        
        networkManager.loadEpisodesData(episodes: episodes) { episodes in
            self.episodes = episodes
        }
    }
    
    //MARK: - Methods
    
    func fetchEpisodesData() {
    }
    
    func updateData() {

        self.view?.updateData()
    }
}

