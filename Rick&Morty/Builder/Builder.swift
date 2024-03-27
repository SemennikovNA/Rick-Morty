//
//  Builder.swift
//  Rick&Morty
//
//  Created by Nikita on 04.03.2024.
//

import UIKit

final class Builder {
    
    //MARK: - Initialize
    
    private init() { }
    

    //MARK: - Static method
    
    static func createMainView() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createDetailView(character: Results, info: InfoModel, origin: OriginModel, episodes: [String]) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, character: character, info: info, origin: origin, episodes: episodes)
        view.presenter = presenter
        return view
    }
    
    static func createSearchView() -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
