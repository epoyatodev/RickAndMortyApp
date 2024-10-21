//
//  CharacterResponse.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 24/9/24.
//

import Foundation

struct CharacterResponse: Codable {
    let info: InfoResult
    let results: [CharacterDTO]
}
