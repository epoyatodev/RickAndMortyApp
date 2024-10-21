//
//  CharactersLogic.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

@Observable
final class CharactersLogic {
    private var charactersService: CharactersServiceProtocol
    private var favoriteManager: FavoriteManager
    
    var characters: [Character] = []
    var charactersFilterText: String = ""
    var selectedGender: Gender = .all
    var selectedSpecies: Species = .all
    var selectedStatus: Status = .all
    var isFavourite: Bool = false
    
    init(charactersService: CharactersServiceProtocol =  CharactersService(), favoriteManager: FavoriteManager = .shared) {
        self.charactersService = charactersService
        self.favoriteManager = favoriteManager
        Task {
            await self.fetchCharacters()
            await self.getAllFav()
        }
    }
    
    @MainActor
    func fetchCharacters(loadMore: Bool = false) async {
        do {
            if loadMore {
                let response = try await self.charactersService.fetchCharacters(with: charactersFilterText, with: selectedStatus, with: selectedGender, with: selectedSpecies, loadMore: loadMore)
                self.characters.append(contentsOf: response)
                Task {
                    await self.getAllFav()
                }
            } else {
                self.characters = try await self.charactersService.fetchCharacters(with: charactersFilterText, with: selectedStatus, with: selectedGender, with: selectedSpecies, loadMore: loadMore)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func needLoadMoreCharacters(lastCharacter: Character) -> Bool {
        return lastCharacter == characters.last && charactersService.responseInfo?.next != nil
    }
    
    @MainActor
    func getAllFav() async {
        favoriteManager.getAllFavorites { result in
            switch result {
            case .success(let characters):
                /// Asign favorites from characters to self.characters
                self.characters.indices.forEach { index in
                    self.characters[index].isFavorite = characters.contains(where: { $0.name == self.characters[index].name})
                }
            case .failure:
                break
            }
        }
    }
    
    @MainActor
    func getFav(from character: String)  {
        favoriteManager.getSingleFavorite(from: character) { character, error in
            if let _ = character {
                self.isFavourite = true
            } else {
                self.isFavourite = false
            }
        }
    }
    
    @MainActor
    func saveFavorite(from character: Character) {
        self.favoriteManager.saveFavorite(character: character.toCharacterSD)
        self.isFavourite = true
        if let index =  self.characters.firstIndex(where: {$0 == character}) {
            self.characters[index].isFavorite = true
        }
    }
    
    @MainActor
    func deleteFavorite(from character: Character) {
        self.favoriteManager.deleteFavorite(from: character.toCharacterSD)
        self.isFavourite = false
        if let index =  self.characters.firstIndex(where: {$0 == character}) {
            self.characters[index].isFavorite = false
        }
    }
    
}
