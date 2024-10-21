//
//  Status.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

enum Status: String, Codable, CaseIterable, PickerOption {
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
