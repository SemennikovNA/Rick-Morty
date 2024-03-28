//
//  TabBarItems.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import UIKit

enum TabBarItems {
    
    case characters
    case search
    

    var title: String {
        
        switch self {
        case .characters: return "Characters"
        case .search: return "Search"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .characters: return UIImage(systemName: "person.3.sequence")
        case .search: return UIImage(systemName: "magnifyingglass.circle")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .characters: return UIImage(systemName: "person.3.sequence.fill")
        case .search: return UIImage(systemName: "magnifyingglass.circle.fill")
        }
    }
}
