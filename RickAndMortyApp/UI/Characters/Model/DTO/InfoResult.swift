//
//  InfoResult.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 24/9/24.
//

import Foundation

struct InfoResult: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
