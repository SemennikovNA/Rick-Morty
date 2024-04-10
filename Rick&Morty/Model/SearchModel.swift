//
//  SearchModel.swift
//  Rick&Morty
//
//  Created by Nikita on 10.04.2024.
//

import Foundation

// MARK: - CharacterSearch

struct CharacterSearch: Codable {
    
    let info: Info
    let results: [CharacterResult]
}

// MARK: - EpisodeSearch

struct EpisodeSearch: Codable {
    
    let info: Info
    let results: [EpisodeResult]
}
