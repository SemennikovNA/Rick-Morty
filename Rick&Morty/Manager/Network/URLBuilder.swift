//
//  URLBuilder.swift
//  Rick&Morty
//
//  Created by Nikita on 24.03.2024.
//

import Foundation

enum URLBuilder {
    
    case character
    case searchCharacter
    case episode
    case location
    case pageRequest
    
    private var baseURL: String {
        return "https://rickandmortyapi.com/api/"
    }
    
    private var path: String {
        switch self {
        case .character: return "character/"
        case .searchCharacter: return "character/?name="
        case .episode: return "episode/?name="
        case .location: return "location/?name="
        case .pageRequest: return "character?page="
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        let request = URLRequest(url: url)
        return request
    }
}
