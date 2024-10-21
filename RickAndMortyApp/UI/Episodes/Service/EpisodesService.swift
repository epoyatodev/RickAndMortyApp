//
//  EpisodesService.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

protocol EpisodesServiceProtocol {
    func fetchFilterEpisodes(filter: [String]) async throws -> [Episode]
}

struct EpisodesService: EpisodesServiceProtocol {
    func fetchFilterEpisodes(filter: [String]) async throws -> [Episode] {
        guard let baseUrl = InfoManager.shared.getUrlString(forKey: .host) else { throw HttpError.invalidURL}
        
        let urlRequest = try RequestBuilder(endpoint: EpisodeEndpoint.episodesFilter(filter).rawValue,
                                            baseURL: baseUrl,
                                            method: .get)
            .buildURLRequest()
        
        let response = try await (URLRequestDispatcher().doRequest(request: urlRequest) as [EpisodeDTO])
        
        return response.map(\.toEpisode)
    }
    
}
