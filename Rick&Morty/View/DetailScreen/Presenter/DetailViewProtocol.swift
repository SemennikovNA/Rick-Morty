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
    
    init(view: DetailViewProtocol, character: CharacterResult)
    var character: CharacterResult { get set }
    var info: [CharacterResult] { get set }
    var origin: [Location] { get set }
    var episodes: [EpisodeResult] { get set }
    func fetchEpisodesData()
    func updateData()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: DetailViewProtocol?
    let networkManager = NetworkManager()
    var character: CharacterResult
    var info: [CharacterResult] = []
    var origin: [Location] = []
    var episodes: [EpisodeResult] = []
    var urlForEpisodes: [String]
    
    //MARK: - Initialization
    
    init(view: DetailViewProtocol, character: CharacterResult) {
        self.view = view
        
        self.info = [character]
        self.origin = [character.origin]
        self.character = character
        self.urlForEpisodes = character.episode
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

