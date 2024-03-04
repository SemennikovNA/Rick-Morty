// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let characters = try? JSONDecoder().decode(Characters.self, from: jsonData)

import Foundation

// MARK: - Characters

struct Charac: Codable, Hashable {
    
    let info: Info
    let results: [Results]
}

// MARK: - Info

struct Info: Codable, Hashable {
    
    let count, pages: Int
    let next: String
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

enum Gender: String, Codable, Hashable {
    
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location

struct Location: Codable, Hashable {
    
    let name: String
    let url: String
}

enum Species: String, Codable, Hashable {
    
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable, Hashable {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
