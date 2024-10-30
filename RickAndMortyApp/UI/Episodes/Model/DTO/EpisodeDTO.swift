//
//  EpisodeDTO.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

struct EpisodeResult: Codable {
    let info: InfoResult?
    let results: [EpisodeDTO]
}
struct EpisodeDTO: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
    }
}

extension EpisodeDTO {
    var toEpisode: Episode {
        Episode(id: id,
                name: name, airDate: airDate,
                episode: episode,
                characters: characters)
    }
}

