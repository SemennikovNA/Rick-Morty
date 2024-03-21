//
//  MainViewSection.swift
//  Rick&Morty
//
//  Created by Nikita on 29.02.2024.
//

import Foundation

enum MainViewSection: Int, CustomStringConvertible, CaseIterable {
    
    case section
    
    var description: String {
        switch self {
        case .section:
            return "section"
        }
    }
}
