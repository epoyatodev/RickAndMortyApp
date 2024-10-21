//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import SwiftUI
import CachedAsyncImage

struct CharacterDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CharactersViewModel.self) private var charactersViewModel
    @State private var bounce = 0
    var character: Character
    var comeFromFavoriteDetails: Bool = false
    var body: some View {
        VStack {
            CachedAsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(.circle)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(.circle)
                    .foregroundStyle(.secondary)
            }
                Text(character.name)
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .bold()
                
                Text(character.species.rawValue)
                    .foregroundStyle(.secondary)
                
                Text(character.status.rawValue)
                .foregroundStyle( character.status == .alive ? .green : .red)
                
            VStack(alignment: .leading, spacing: 20) {
                    Button {
                        self.bounce += 1
                        // TODO:
                        if charactersViewModel.charactersLogic.isFavourite {
                            charactersViewModel.charactersLogic.deleteFavorite(from: character)
                            Task {
                                await charactersViewModel.charactersLogic.getAllFav()
                            }
                            if comeFromFavoriteDetails {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    dismiss()
                                }
                            }
                        } else {
                            charactersViewModel.charactersLogic.saveFavorite(from: character)
                            Task {
                                await charactersViewModel.charactersLogic.getAllFav()
                            }
                        }
                    } label: {
                        Image(systemName: charactersViewModel.charactersLogic.isFavourite ? "heart.fill" : "heart")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.red)
                            .symbolEffect(.bounce, value: bounce)
                    }
                    .padding(10)
                    .background(.white)
                    .clipShape(.capsule)
                    .foregroundStyle(.primary)
                    .shadow(radius: 5)
                    .bold()
                    
                    
                    VStack(alignment: .leading) {
                        Text("Last Known Location")
                            .font(.title3)
                            .bold()
                        Text(character.location.name)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        Text("Origin")
                            .font(.title3)
                            .bold()
                        Text(character.origin.name)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(10)
            
            VStack(alignment: .leading) {
                Text("Episodes")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(charactersViewModel.episodesLogic.episodes) { episode in
                            VStack(alignment: .leading, spacing: 10) {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 130, height: 150)
                                        .clipShape(.rect(cornerRadius: 10))
                                        .foregroundStyle(.blue.opacity(0.2))
                                    
                                    Text(episode.episode)
                                        .font(.title3)
                                        .bold()
                                }
                                Text(episode.airDate)
                                    .font(.caption)
                                    .bold()
                                    .lineLimit(0)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                
            }
            
            

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(character.name)
    }
}

#Preview {
    CharacterDetailView(character: .mock)
        .environment(CharactersViewModel(charactersLogic: .init(charactersService: CharactersServiceTest()), episodesLogic: .init(episodesService: EpisodesServiceTest())))
}


