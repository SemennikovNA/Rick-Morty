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
    var location: [OriginModel] { get set }
    var episode: [Episodes] { get set }
    func searchData(_ text: String, flag: String)
    func updateData()
}

final class SearchPresenter: SearchPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: SearchViewProtocol?
    var networkManager = NetworkManager.shared
    var character: [InfoModel] = []
    var location: [OriginModel] = []
    var episode: [Episodes] = []
    
    //MARK: - Initialization
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    //MARK: - Methods
    
    func searchData(_ text: String, flag: String) {
        var url: URLRequest
        switch flag {
        case "Character":
            url = URLBuilder.searchCharacter.request
            guard let urlString = url.url?.relativeString else { return }
            print("\(urlString)\(text)")
            return
        case "Episode":
            url = URLBuilder.episode.request
            guard let urlString = url.url?.relativeString else { return }
            print("\(urlString)\(text)")
            return
        case "Location":
            url = URLBuilder.location.request
            guard let urlString = url.url?.relativeString else { return }
            print("\(urlString)\(text)")
            return
        default:
            break
        }
        
        print(text)
        
    }
    
    func updateData() {
        
    }
}
