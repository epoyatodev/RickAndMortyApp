//
//  TabItems.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 14/10/24.
//

import Foundation

enum TabItem: String, CaseIterable {
    case characters = "Characters"
    case episodes = "Episodes"
    case locations = "Locations"
    case settings = "Favorites"
    
    var image: String {
        switch self {
        case .characters: return "person"
        case .episodes: return "tv"
        case .locations: return "globe"
        case .settings: return "heart"
        }
    }
}
