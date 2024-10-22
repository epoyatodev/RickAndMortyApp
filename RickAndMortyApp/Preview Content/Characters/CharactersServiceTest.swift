//
//  CharactersServiceTest.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

struct CharactersServiceTest: CharactersServiceProtocol {
    mutating func fetchCharacters(with name: String = "", with status: Status, with gender: Gender, with species: Species, loadMore: Bool) async throws -> [Character] {
        return .mock
    }
}

extension Character {
    static let mock: Character = .init(id: 1, name: "Rick Sanchez", status: .alive, species: .human, gender: .male, image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), location: .init(name: "Location 1", url: "url location"), origin: .init(name: "Origin1", url: "url origin"), episodes: ["1", "2", "3"])
}
extension [Character] {
    static let mock: [Character] = [
        .init(id: 1, name: "Rick Sanchez", status: .alive, species: .human, gender: .male, image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), location: .init(name: "Location 1", url: "url location"), origin: .init(name: "Origin1", url: "url origin"), episodes: ["1", "2", "3"]),
        .init(id: 2, name: "Morty Smith", status: .dead, species: .human, gender: .male, image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"), location: .init(name: "Location 1", url: "url location"), origin: .init(name: "Origin1", url: "url origin"), episodes: ["1", "2", "3"]),
        .init(id: 2, name: "Morty Smith", status: .unknown, species: .human, gender: .male, image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"), location: .init(name: "Location 1", url: "url location"), origin: .init(name: "Origin1", url: "url origin"), episodes: ["1", "2", "3"])
    ]
}


