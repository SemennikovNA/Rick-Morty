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
    
    init(view: DetailViewProtocol, info: InfoModel, origin: OriginModel, episodes: [String])
    var info: [InfoModel] { get set }
    var origin: [OriginModel] { get set }
    var episodes: [EpisodesModel] { get set }
    func updateData()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    
    //MARK: - Properties
    
    weak var view: DetailViewProtocol?
    let networkManager = NetworkManager()
    var info: [InfoModel] = []
    var origin: [OriginModel] = []
    var episodes: [EpisodesModel] = []
    
    //MARK: - Initialization
    
    init(view: DetailViewProtocol, info: InfoModel, origin: OriginModel, episodes: [String]) {
        self.view = view
        
        self.info.removeAll()
        self.origin.removeAll()
        self.info = [info]
        self.origin = [origin]
        
        // TODO: - Здесь установить инфу в массив episodes, сначала нужно очистить массив
//        let episodeName = data
//        self.episodes.removeAll()
    }
    
    //MARK: - Methods
    
    func updateData() {

        self.view?.updateData()
    }
}

