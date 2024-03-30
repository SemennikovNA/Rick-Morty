//
//  MainViewProtocol.swift
//  Rick&Morty
//
//  Created by Nikita on 04.03.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func updateData()
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol)
    var characters: [Results] { get set }
    func loadMoreData(pageNumber: Int)
    func fetchData()
    func updateData()
}

final class MainPresenter: MainPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: MainViewProtocol?
    let networkManager = NetworkManager()
    var characters: [Results] = []
    
    //MARK: - Initialize

    init(view: MainViewProtocol) {
        self.view = view
        
        self.networkManager.delegate = self
    }
    
    //MARK: - Method
    
    func fetchData() {
        networkManager.fetchData(url: URLBuilder.character.request)
    }

    func updateData() {
        self.view?.updateData()
    }
    
    func loadMoreData(pageNumber: Int) {
        guard let url = URL(string: "\(URLBuilder.pageRequest.request)\(pageNumber)") else { return }
        print(url)
        let urlForRequest = URLRequest(url: url)
        networkManager.loadMoreData(url: urlForRequest)
    }
}

extension MainPresenter: LoadedInformation {
    
    func transitData(_ networkManager: NetworkManager, data: [Results]) {
        DispatchQueue.main.async {
            self.characters.append(contentsOf: data)
            self.updateData()
         }
    }
}
