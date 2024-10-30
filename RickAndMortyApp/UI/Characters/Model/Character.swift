//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

struct Character: Identifiable, Hashable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let gender: Gender
    let image: URL?
    let location: LocationOrigin
    let origin: LocationOrigin
    let episodes: [String]
    var isFavorite: Bool = false
}

extension Character {
    var toCharacterSD: CharacterSD {
        .init(id: id, name: name, status: .init(status: status.rawValue), species: .init(specie: species.rawValue), gender: .init(gender: gender.rawValue), image: image , location: .init(name: location.name), origin: .init(name: origin.name), episodes: episodes.map { EpisodesSD(episode: $0)})
    }
}
