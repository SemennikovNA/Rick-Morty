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

// MARK: - Character

struct CharacterResult: Codable, Sendable {
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Episode

//struct EpisodeResult: Codable {
//    let id: Int
//    let name, airDate, episode: String
//    let characters: [String]
//    let url: String
//    let created: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case airDate = "air_date"
//        case episode, characters, url, created
//    }
//}
