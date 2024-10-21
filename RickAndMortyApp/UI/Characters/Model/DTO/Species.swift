//
//  Species.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

enum Species: String, Codable, CaseIterable, PickerOption {
    case all = "All"
    case human = "Human"
    case alien = "Alien"
    case humanoid = "Humanoid"
    case poopybutthole = "Poopybutthole"
    case mythicalCreature = "Mythological Creature"
    case animal = "Animal"
    case robot = "Robot"
    case disease = "Disease"
    case parasite = "Parasite"
    case vampire = "Vampire"
    case cronenberg = "Cronenberg"
    case unknown = "unknown"
}
