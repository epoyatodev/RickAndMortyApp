//
//  CharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

@Observable
final class CharactersViewModel {
    var charactersLogic: CharactersLogic
    var episodesLogic: CharactersEpisodesLogic
    
    init(charactersLogic: CharactersLogic = .init(), episodesLogic: CharactersEpisodesLogic = .init()) {
        self.charactersLogic = charactersLogic
        self.episodesLogic = episodesLogic
    }
}
