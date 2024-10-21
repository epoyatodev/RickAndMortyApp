//
//  FavoritesModelLogic.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 21/10/24.
//

import Foundation

@Observable
final class FavoritesModelLogic {
    private let favoriteManager: FavoriteManager
    var favoriteCharacters: [Character] = []
    
    init(favoriteManager: FavoriteManager = .shared) {
        self.favoriteManager = favoriteManager
    }
    
    @MainActor
    func fetchFavorites() async {
        favoriteManager.getAllFavorites { result in
            switch result {
            case .success(let favorites):
                DispatchQueue.main.async {
                    self.favoriteCharacters = favorites.map(\.toCharacter)
                }
            case .failure:
                self.favoriteCharacters = []
            }
        }
    }
}
