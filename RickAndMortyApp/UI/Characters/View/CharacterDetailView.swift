//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import SwiftUI
import CachedAsyncImage

struct CharacterDetailView: View {
    @Binding var charactersViewModel: CharactersViewModel
    var character: Character
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
                        // TODO:
                        if charactersViewModel.charactersLogic.isFavourite {
                            charactersViewModel.charactersLogic.deleteFavorite(from: character)
                        } else {
                            charactersViewModel.charactersLogic.saveFavorite(from: character)
                        }
                    } label: {
                        Text(charactersViewModel.charactersLogic.isFavourite ? "Delete Favorite 💔" : "Favorite ♥️")
                            .frame(maxWidth: .infinity)
                    }
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
                    .foregroundStyle(.primary)
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
    CharacterDetailView(charactersViewModel: .constant(.init(charactersLogic: .init(charactersService: CharactersServiceTest()), episodesLogic: .init(episodesService: EpisodesServiceTest()))), character: .mock)
}


