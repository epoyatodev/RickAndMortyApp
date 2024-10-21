//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import SwiftUI

struct CharactersView: View {
    @Environment(TabBarViewModel.self) private var tabBarViewModel
    @State var viewModel: CharactersViewModel = .init()
    @State private var presentFiltersSheet: Bool = false
    @State private var showProgress: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { reader in
                ScrollView {
                    HStack(spacing: 0) {
                        CustomSearchBar(searchText: $viewModel.charactersLogic.charactersFilterText)
                        Button {
                            presentFiltersSheet.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                        .foregroundStyle(.blue)
                        .padding(.trailing)
                    }
                    .id(0)
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), spacing: 10) {
                        ForEach(viewModel.charactersLogic.characters) { character in
                            NavigationLink(value: character) {
                                CharacterCell(charactersViewModel: $viewModel, character: character)
                                    .onAppear {
                                        if viewModel.charactersLogic.needLoadMoreCharacters(lastCharacter: character) {
                                            self.showProgress.toggle()
                                        }
                                    }
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                    .padding()
                    
                    if showProgress {
                        ProgressView()
                            .task {
                                try? await Task.sleep(for: .seconds(2))
                                await viewModel.charactersLogic.fetchCharacters(loadMore: true)
                                self.showProgress.toggle()
                            }
                    }
                }
                .navigationTitle("Characters")
                .navigationDestination(for: Character.self, destination: { character in
                    CharacterDetailView(charactersViewModel: $viewModel, character: character)
                        .task {
                            viewModel.charactersLogic.getFav(from: character.name)
                            viewModel.episodesLogic.extractEpisodes(from: character.episodes)
                            await viewModel.episodesLogic.fetchFilterEpisodes()
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
                .onChange(of: viewModel.charactersLogic.charactersFilterText) { _, newValue in
                    Task {
                        await viewModel.charactersLogic.fetchCharacters()
                    }
                }
                .sheet(isPresented: $presentFiltersSheet) {
                    CharactersFiltersView(viewModel: $viewModel)
                }
                .onScrollGeometryChange(for: CGFloat.self) { proxy in
                    proxy.contentOffset.y
                } action: { oldValue, newValue in
                    tabBarViewModel.showOrHideTabBar(oldValue: oldValue, newValue: newValue, showProgress: showProgress)
                }
                .onReceive(NotificationCenter.default.publisher(for: .itemTabbarTap)) { notification in
                    if let tabItem = notification.userInfo?["tabItem"] as? TabItem, tabItem == .characters {
                        withAnimation {
                            reader.scrollTo(0)
                        }
                    }
                }
            }            
        }
    }
}

#Preview {
    CharactersView(viewModel: .init(charactersLogic: .init(charactersService: CharactersServiceTest())))
        .environment(TabBarViewModel())
}



