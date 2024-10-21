//
//  FavoritesViewModel.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 21/10/24.
//

import Foundation

@Observable
final class FavoritesViewModel {
    var favoritesModelLogic: FavoritesModelLogic
    
    init(favoritesModelLogic: FavoritesModelLogic = .init()) {
        self.favoritesModelLogic = favoritesModelLogic
    }
}
