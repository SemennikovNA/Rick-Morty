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
    }
    
    //MARK: - Method
    
    func updateData() {
        self.view.updateData()
    }
}
