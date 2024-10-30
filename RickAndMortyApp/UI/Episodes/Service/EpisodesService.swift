//
//  EpisodesService.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

protocol EpisodesServiceProtocol {
    func fetchEpisodes(filter: [String]?) async throws -> [Episode]
}

struct EpisodesService: EpisodesServiceProtocol {
    func fetchEpisodes(filter: [String]?) async throws -> [Episode] {
        guard let baseUrl = InfoManager.shared.getUrlString(forKey: .host) else { throw HttpError.invalidURL}
        
        let urlRequest = try RequestBuilder(endpoint: filter != nil ? EpisodeEndpoint.episodesFilter(filter!).rawValue : EpisodeEndpoint.allEpisodes.rawValue,
                                            baseURL: baseUrl,
                                            method: .get)
            .buildURLRequest()
        if let filter {
            let response = try await (URLRequestDispatcher().doRequest(request: urlRequest) as [EpisodeDTO])
            return response.map(\.toEpisode)
        } else {
            let response = try await (URLRequestDispatcher().doRequest(request: urlRequest) as EpisodeResult)
            return response.results.map(\.toEpisode)
        }
    }
}
