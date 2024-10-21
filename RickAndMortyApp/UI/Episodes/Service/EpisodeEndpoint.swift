//
//  EpisodeEndpoint.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

enum EpisodeEndpoint {
    case allEpisodes
    case episodesFilter([String])
    
    var rawValue: String {
        switch self {
        case .allEpisodes: 
            return "/episode"
        case .episodesFilter(let filter):
            return "/episode/\(filter.joined(separator: ","))"
        }
    }
}
