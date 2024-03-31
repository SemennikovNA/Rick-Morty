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
    var character: [InfoModel] { get set }
    var charac: [Results] { get set }
    var location: [OriginModel] { get set }
    var episode: [Episodes] { get set }
    func searchData(_ text: String, flag: String)
    func searchCharacter(_ requestUrl: URL)
    func searchEpisode(_ requestUrl: URL)
    func searchLocation(_ requestUrl: URL)
    func updateData()
}

final class SearchPresenter: SearchPresenterProtocol, LoadedInformation {
    
    //MARK: - Properties
    
    weak var view: SearchViewProtocol?
    var networkManager = NetworkManager.shared
    var character: [InfoModel] = []
    var location: [OriginModel] = []
    var episode: [Episodes] = []
    
    // Проверочная переменная
    var charac: [Results] = []
    
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
            searchCharacter(urlString)
            return
        case "Episode":
            mainPathUrl = URLBuilder.episode.request
            guard let url = mainPathUrl.url?.relativeString else { return }
            guard let urlString = URL(string: "\(url)\(text)") else {
                print(NetworkError.badUrl)
                return
            }
            searchEpisode(urlString)
            return
        case "Location":
            mainPathUrl = URLBuilder.location.request
            guard let url = mainPathUrl.url?.relativeString else { return }
            guard let urlString = URL(string: "\(url)\(text)") else {
                print(NetworkError.badUrl)
                return
            }
            searchLocation(urlString)
            return
        default:
            break
        }
        print(text)
    }
    
    func searchCharacter(_ requestUrl: URL) {
        print(requestUrl)
        networkManager.characterSearchRequest(requestUrl)
    }
    
    func searchEpisode(_ requestUrl: URL) {
        print(requestUrl)
    }
    
    func searchLocation(_ requestUrl: URL) {
        print(requestUrl)
        networkManager.locationSearchRequest(requestUrl)
    }
    
    func updateData() {
        self.view?.updateData()
    }
    
    func transitData(_ networkManager: NetworkManager, data: [Results]) {
        print("work?")
        self.charac = data
        print(charac)
    }
}
