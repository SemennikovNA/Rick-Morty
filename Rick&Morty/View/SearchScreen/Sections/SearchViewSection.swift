//
//  SearchViewSection.swift
//  Rick&Morty
//
//  Created by Nikita on 31.03.2024.
//

import Foundation

enum SearchViewSection: Int, CustomStringConvertible, CaseIterable {
    
    case character
    case location
    case episode
    
    var description: String {
        switch self {
        case .character:
            return "character"
        case .location:
            return "location"
        case .episode:
            return "episode"
        }
    }
}
