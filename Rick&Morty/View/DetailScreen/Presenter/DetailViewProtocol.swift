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
    
    init(view: DetailViewProtocol, character: CharacterResult, info: InfoModel, origin: OriginModel, episodes: [String])
    var character: CharacterResult { get set }
    var info: [InfoModel] { get set }
    var origin: [OriginModel] { get set }
    var episodes: [EpisodeResult] { get set }
    func fetchEpisodesData()
    func updateData()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: DetailViewProtocol?
    let networkManager = NetworkManager()
    var character: CharacterResult
    var info: [InfoModel] = []
    var origin: [OriginModel] = []
    var episodes: [EpisodeResult] = []
    var urlForEpisodes: [String]
    
    //MARK: - Initialization
    
    init(view: DetailViewProtocol, character: CharacterResult, info: InfoModel, origin: OriginModel, episodes: [String]) {
        self.view = view
        
        self.info = [info]
        self.origin = [origin]
        self.character = character
        self.urlForEpisodes = episodes
    }

    
    //MARK: - Methods
    
    func fetchEpisodesData() {
        networkManager.loadEpisodesData(episodes: self.urlForEpisodes) { episodes in
            self.episodes.removeAll()
            self.episodes = episodes
        }
    }
    
    func updateData() {
        self.view?.updateData()
    }
}

