//
//  SearchViewProtocol.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    
    func updateData()
}

protocol SearchPresenterProtocol: AnyObject {
    
    init(view: SearchViewProtocol)
    var networkManager: NetworkManager { get }
    var character: [CharacterResult] { get set }
    var location: [Location] { get set }
    var episode: [EpisodeResult] { get set }
    func searchData(_ text: String, flag: String)
    func characterSearchRequest(_ requestUrl: URL)
    func episodeSearchRequest(_ requestUrl: URL)
    func locationSearchRequest(_ requestUrl: URL)
    func removeData()
    func updateData()
}

final class SearchPresenter: SearchPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: SearchViewProtocol?
    var networkManager = NetworkManager.shared
    var character: [CharacterResult] = []
    var location: [Location] = []
    var episode: [EpisodeResult] = []
    
    //MARK: - Initialization
    
    init(view: SearchViewProtocol) {
        self.view = view
        self.networkManager.delegate = self
    }
    
    //MARK: - Methods
    
    func searchData(_ text: String, flag: String) {
        var mainPathUrl: URLRequest
        switch flag {
        case "Character":
            mainPathUrl = URLBuilder.searchCharacter.request
            guard let url = mainPathUrl.url?.relativeString else { return }
            guard let urlString = URL(string: "\(url)\(text)") else {
                print(NetworkError.badUrl)
                return
            }
            characterSearchRequest(urlString)
            return
        case "Episode":
            mainPathUrl = URLBuilder.episode.request
            guard let url = mainPathUrl.url?.relativeString else { return }
            guard let urlString = URL(string: "\(url)\(text)") else {
                print(NetworkError.badUrl)
                return
            }
            episodeSearchRequest(urlString)
            return
        case "Location":
            mainPathUrl = URLBuilder.location.request
            guard let url = mainPathUrl.url?.relativeString else { return }
            guard let urlString = URL(string: "\(url)\(text)") else {
                print(NetworkError.badUrl)
                return
            }
            locationSearchRequest(urlString)
            return
        default:
            break
        }
    }
    
    func characterSearchRequest(_ requestUrl: URL) {
        removeData()
        networkManager.characterSearchRequest(requestUrl)
    }
    
    func episodeSearchRequest(_ requestUrl: URL) {
        removeData()
        networkManager.episodeSearchRequest(requestUrl)
    }
    
    func locationSearchRequest(_ requestUrl: URL) {
        removeData()
        networkManager.locationSearchRequest(requestUrl)
    }
    
    func removeData() {
        self.character.removeAll()
        self.episode.removeAll()
        self.location.removeAll()
    }
    
    func updateData() {
        self.view?.updateData()
    }
}

//MARK: - LoadedInformation method

extension SearchPresenter: LoadedInformation {
    
    func transferData(_ networkManager: NetworkManager, data: [CharacterResult]) {
        self.character = data
        self.updateData()
    }
    
    func searchEpisodeData(_ networkManager: NetworkManager, data: [EpisodeResult]) {
        self.episode = data
        self.updateData()
    }
    
    func searchLocationData(_ networkManager: NetworkManager, data: [Location]) {
        self.location = data
        self.updateData()
    }
}
