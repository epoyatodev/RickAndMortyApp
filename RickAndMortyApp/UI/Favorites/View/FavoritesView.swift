//
//  FavoritesView.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 21/10/24.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(CharactersViewModel.self) private var charactersViewModel
    @Environment(TabBarViewModel.self) private var tabBarViewModel
    @State var viewModel: FavoritesViewModel = .init()
    @State var edge = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.favoritesModelLogic.favoriteCharacters) { character in
                    NavigationLink(value: character) {
                        HStack {
                            CharacterCell(character: character, toFavoriteList: true)
                            Text(character.name)
                                .font(.subheadline)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                Task {
                                    charactersViewModel.charactersLogic.deleteFavorite(from: character)
                                    await viewModel.favoritesModelLogic.fetchFavorites()
                                    await charactersViewModel.charactersLogic.getAllFav()
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .padding(.bottom, character == viewModel.favoritesModelLogic.favoriteCharacters.last ? edge!.bottom + 15 : 0)
                }
            }
            .onScrollGeometryChange(for: CGFloat.self) { proxy in
                proxy.contentOffset.y
            } action: { oldValue, newValue in
                tabBarViewModel.showOrHideTabBar(oldValue: oldValue, newValue: newValue)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Character.self, destination: { character in
                CharacterDetailView(character: character, comeFromFavoriteDetails: true)
                    .task {
                        charactersViewModel.charactersLogic.getFav(from: character.name)
                        await charactersViewModel.episodesLogic.extractEpisodes(from: character.episodes)
                        await charactersViewModel.episodesLogic.fetchFilterEpisodes()
                    }
                    .onAppear {
                        withAnimation {
                            tabBarViewModel.showTabBar = false
                        }
                    }
                    .onDisappear {
                        withAnimation {
                            tabBarViewModel.showTabBar = true
                        }
                    }
            })
            .overlay {
                if viewModel.favoritesModelLogic.favoriteCharacters.isEmpty{
                    ContentUnavailableView("Not favorites yet", systemImage: "heart.slash")
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favorites")
            .task {
                await self.viewModel.favoritesModelLogic.fetchFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView(viewModel: .init(favoritesModelLogic: .init(favoriteManager: FavoriteManagerTest())))
        .environment(CharactersViewModel(charactersLogic: .init(charactersService: CharactersServiceTest()), episodesLogic: .init(episodesService: EpisodesServiceTest())))
        .environment(TabBarViewModel())
}
