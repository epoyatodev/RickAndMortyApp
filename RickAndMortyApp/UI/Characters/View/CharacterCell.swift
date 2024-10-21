//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import SwiftUI
import CachedAsyncImage

struct CharacterCell: View {
    @Environment(CharactersViewModel.self) private var charactersViewModel
    var character: Character
    
    var body: some View {
        VStack(spacing: 0.0) {
            CachedAsyncImage(url: character.image) { Image in
                Image
                    .resizable()
                    .frame(width: 180, height: 180)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(character.name)
                        .bold()
                        .font(.subheadline)
                        .lineLimit(1)
                    Text(character.species.rawValue)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                Spacer()
                
                VStack {
                    Image(systemName: character.status == .alive ? "circle.fill" : character.status == .unknown ? "xmark.circle" : "circle")
                        .foregroundStyle(character.status == .alive ? .green : .red)
                        .font(.footnote)
                    Text(character.status.rawValue)
                        .font(.caption)
                }
                .foregroundStyle(.primary)
            }
            .padding()
            .background(.white)
            .frame(width: 180)

        }
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3, x: 3, y: 3)
        .overlay(alignment: .topTrailing) {
            Image(systemName: character.isFavorite ? "heart.fill" : "heart")
                .padding(5)
                .foregroundStyle(character.isFavorite ? .red : .white)
                .bold()
        }

    }
}

#Preview {
    CharacterCell(character: .mock)
        .frame(width: 180)
        .environment(CharactersViewModel(charactersLogic: .init(charactersService: CharactersServiceTest()), episodesLogic: .init(episodesService: EpisodesServiceTest())))
}
