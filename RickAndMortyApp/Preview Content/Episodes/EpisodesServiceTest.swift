//
//  EpisodesServiceTest.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

struct EpisodesServiceTest: EpisodesServiceProtocol {
    func fetchFilterEpisodes(filter: [String]) async throws -> [Episode] {
        return .mock
    }
}

extension Episode {
    static let mock: Episode = .init(id: 0, name: "The Ricklantis Mixup",
                                     airDate: "September 10, 2017",
                                     episode: "S03E07",
                                     characters: [
                                        "https://rickandmortyapi.com/api/character/1",
                                        "https://rickandmortyapi.com/api/character/2",
                                     ])
}
extension [Episode] {
    static let mock: [Episode] = [
        .init(id: 0, name: "The Ricklantis Mixup",
              airDate: "September 10, 2017",
              episode: "S03E07",
              characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
              ]),
        .init(id: 0, name: "The Ricklantis Mixup",
              airDate: "September 10, 2017",
              episode: "S03E07",
              characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
              ]),
        .init(id: 0, name: "The Ricklantis Mixup",
              airDate: "September 10, 2017",
              episode: "S03E07",
              characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
              ]),
        .init(id: 0, name: "The Ricklantis Mixup",
              airDate: "September 10, 2017",
              episode: "S03E07",
              characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
              ]),
        .init(id: 0, name: "The Ricklantis Mixup",
              airDate: "September 10, 2017",
              episode: "S03E07",
              characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
              ]),
        .init(id: 0, name: "The Ricklantis Mixup",
              airDate: "September 10, 2017",
              episode: "S03E07",
              characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
              ])
    ]
}
