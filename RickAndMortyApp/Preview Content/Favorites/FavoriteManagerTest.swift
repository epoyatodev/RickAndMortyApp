//
//  FavoriteManagerTest.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 22/10/24.
//

import Foundation

struct FavoriteManagerTest: FavoriteProtocol {
    func getAllFavorites(completion: @escaping (Result<[CharacterSD], any Error>) -> Void) {
        completion(.success([Character].mock.map(\.toCharacterSD)))
    }
}

extension FavoriteProtocol {
    func getSingleFavorite(from character: String, completion: @escaping (CharacterSD?, String?) -> Void) {}
    func deleteFavorite(from character: CharacterSD) {}
    func saveFavorite(character: CharacterSD) {}
}
