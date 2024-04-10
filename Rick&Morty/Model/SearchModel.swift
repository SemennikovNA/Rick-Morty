//
//  SearchModel.swift
//  Rick&Morty
//
//  Created by Nikita on 10.04.2024.
//

import Foundation

// MARK: - Character search

struct CharacterSearch: Codable {
    
    let info: Info
    let results: [CharacterResult]
}

// MARK: - Episode search

struct EpisodeSearch: Codable {
    
    let info: Info
    let results: [EpisodeResult]
}

// MARK: - Locations earch

struct LocationSearch: Codable {
    
    let info: Info
    let results: [LocationResult]
}
