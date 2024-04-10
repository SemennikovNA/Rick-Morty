//
//  AllModel.swift
//  Rick&Morty
//
//  Created by Nikita on 22.03.2024.
//


import Foundation

// MARK: - Characters

struct Character: Codable, Hashable {
    
    let info: Info
    let results: [CharacterResult]
}

// MARK: - Info

struct Info: Codable, Hashable {
    
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result

struct CharacterResult: Codable, Hashable {
    
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
}

// MARK: - Episodes

struct EpisodeResult: Codable, Hashable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

// MARK: - Location

struct Location: Codable, Hashable {
    
    let name: String
    let url: String
}

// MARK: - Gender

enum Gender: String, Codable, Hashable {
    
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Status

enum Status: String, Codable, Hashable {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
