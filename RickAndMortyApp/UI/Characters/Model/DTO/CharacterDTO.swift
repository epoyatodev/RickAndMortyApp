//
//  CharacterDTO.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin: LocationOrigin
    let location: LocationOrigin
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

extension CharacterDTO {
    var toCharacters: Character {
        Character(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: gender,
            image: URL(string: image),
            location: location,
            origin: origin,
            episodes: episode)
        
    }
}
