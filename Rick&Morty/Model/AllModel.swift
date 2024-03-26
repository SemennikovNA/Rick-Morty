//
//  AllModel.swift
//  Rick&Morty
//
//  Created by Nikita on 22.03.2024.
//


import Foundation

// MARK: - Characters

struct Charac: Codable, Hashable {
    
    let results: [Results]
}

// MARK: - Result

struct Results: Codable, Hashable {
    
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin: Location
    let image: String
    let episode: [String]
    let url: String
}

// MARK: - Episodes

struct EpisodesModel: Codable, Hashable {
    
    let name: String
    let air_date: String
    let episode: String
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

// MARK: - Species

enum Species: String, Codable, Hashable {
    
    case alien = "Alien"
    case human = "Human"
}

// MARK: - Status

enum Status: String, Codable, Hashable {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

