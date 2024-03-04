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
    
    static func createDetailView() -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
