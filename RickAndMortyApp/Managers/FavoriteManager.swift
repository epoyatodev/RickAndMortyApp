//
//  FavoriteManager.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

final class FavoriteManager {
    static let shared = FavoriteManager()
    private let swiftDataManager: SwiftDataManager = .shared
    
    private init() {}
    
    @MainActor
    func getSingleFavorite(from character: String, completion: @escaping (CharacterSD?, String?) -> Void) {
        let predicate = #Predicate<CharacterSD> {
            $0.name == character
        }
        swiftDataManager.fetchOne(model: CharacterSD.self, filter: predicate, completion: completion)
    }
    
    @MainActor
    func getAllFavorites(completion: @escaping (Result<[CharacterSD], Error>) -> Void) {
        swiftDataManager.fetchAll(model: CharacterSD.self, completion: completion)
    }
    
    @MainActor
    func deleteFavorite(from character: CharacterSD) {
        self.getSingleFavorite(from: character.name) { character, error in
            if let character {
                self.swiftDataManager.delete(model: character)
            }
            
        }
    }
    
    @MainActor
    func saveFavorite(character: CharacterSD) {
        self.swiftDataManager.insert(model: character)
    }
}
