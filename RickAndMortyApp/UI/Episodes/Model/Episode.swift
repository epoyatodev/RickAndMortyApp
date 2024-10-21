//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

struct Episode: Identifiable, Hashable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
}
