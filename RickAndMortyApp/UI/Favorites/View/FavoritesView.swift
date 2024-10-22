//
//  FavoritesView.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 21/10/24.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(CharactersViewModel.self) private var charactersViewModel
    @State private var viewModel: FavoritesViewModel = .init()
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.favoritesModelLogic.favoriteCharacters) { character in
                    NavigationLink(value: character) {
                        Text(character.name)
                    }
                }
            }
            .navigationDestination(for: Character.self, destination: { character in
                CharacterDetailView(character: character, comeFromFavoriteDetails: true)
                    .task {
                        charactersViewModel.charactersLogic.getFav(from: character.name)
                        await charactersViewModel.episodesLogic.extractEpisodes(from: character.episodes)
                        await charactersViewModel.episodesLogic.fetchFilterEpisodes()
                    }
            })
            .overlay {
                if viewModel.favoritesModelLogic.favoriteCharacters.isEmpty{
                    ContentUnavailableView("Not favorites yet", systemImage: "heart.slash")
                }
            }
            .navigationTitle("Favorites")
            .task {
                await self.viewModel.favoritesModelLogic.fetchFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environment(CharactersViewModel(charactersLogic: .init(charactersService: CharactersServiceTest()), episodesLogic: .init(episodesService: EpisodesServiceTest())))
}
