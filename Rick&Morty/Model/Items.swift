//
//  InfoModel.swift
//  Rick&Morty
//
//  Created by Nikita on 22.03.2024.
//

import Foundation

struct Items: Hashable {
    
    var info: InfoModel?
    var origin: OriginModel?
    var episodes: EpisodesModel?
}


struct InfoModel: Hashable {
    
    var species: String
    var type: String
    var gender: String
}

struct OriginModel: Hashable {
    
    var planetName: Location
    var imageName: Location
}

struct EpidsodesModel: Hashable {
    
    var episodesName: String
    var episodesSeasonNumber: String
    var episodesDate: String
}
