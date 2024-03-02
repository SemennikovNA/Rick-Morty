//
//  BaseApiResponse.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import Foundation

class BaseApiResponse: Codable {
     
    let characters: String
    let locations: String
    let episodes: String
}
