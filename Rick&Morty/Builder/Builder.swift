//
//  Builder.swift
//  Rick&Morty
//
//  Created by Nikita on 04.03.2024.
//

import UIKit

final class Builder {
    
    private init() { }
    
    static func createDetailView() -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
