//
//  MainViewSection.swift
//  Rick&Morty
//
//  Created by Nikita on 04.03.2024.
//

import Foundation

enum DetailViewSection: Int, CustomStringConvertible, CaseIterable {
    
    case info
    case origin
    case episodes
    
    var description: String {
        switch self {
        case .info:
            return "info"
        case .origin:
            return "origin"
        case .episodes:
            return "episodes"
        }
    }
}
