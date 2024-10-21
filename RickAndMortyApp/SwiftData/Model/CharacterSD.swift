//
//  CharacterSD.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation
import SwiftData

@Model
class CharacterSD {
    @Attribute(.unique) var id: Int
    var name: String
    var status: StatusSD
    var species: SpeciesSD
    var gender: GenderSD
    var image: URL?
    var location: LocationOriginSD
    var origin: LocationOriginSD
    var episodes: [EpisodesSD]
    
    
    init(id: Int, name: String, status: StatusSD, species: SpeciesSD, gender: GenderSD, image: URL? = nil, location: LocationOriginSD, origin: LocationOriginSD, episodes: [EpisodesSD]) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
        self.location = location
        self.origin = origin
        self.episodes = episodes
    }
}

extension CharacterSD {
    var toCharacter: Character {
        return Character(id: id, name: name, status: .init(rawValue: status.status) ?? .alive, species: .init(rawValue: species.specie) ?? .alien, gender: .init(rawValue: gender.gender) ?? .all, image: image, location: .init(name: location.name, url: ""), origin: .init(name: origin.name, url: ""), episodes: episodes.map({ $0.episode }), isFavorite: true)
    }
}
@Model
class EpisodesSD {
    var episode: String
    
    init(episode: String) {
        self.episode = episode
    }
}
@Model
class SpeciesSD {
    var specie: String
    
    init(specie: String) {
        self.specie = specie
    }
}

@Model
class GenderSD {
    var gender: String
    
    init(gender: String) {
        self.gender = gender
    }
}

@Model
class LocationOriginSD {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

@Model
class StatusSD {
    var status: String
    
    init(status: String) {
        self.status = status
    }
}
