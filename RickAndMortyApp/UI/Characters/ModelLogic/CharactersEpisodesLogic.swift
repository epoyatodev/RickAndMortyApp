//
//  EpisodesLogic.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 16/10/24.
//

import Foundation

@Observable
final class CharactersEpisodesLogic {
    private var episodesService: EpisodesServiceProtocol
    var episodes: [Episode] = []
    var episodesToFilter: [String] = []
    
    init(episodesService: EpisodesServiceProtocol = EpisodesService()) {
        self.episodesService = episodesService
    }
    
    @MainActor
    func fetchFilterEpisodes() async {
        do {
            self.episodes = try await episodesService.fetchEpisodes(filter: episodesToFilter)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func extractEpisodes(from url: [String]) async {
        self.episodesToFilter.removeAll()
        url.forEach { url in
            if let lastComponent = url.components(separatedBy: "/").last {
                self.episodesToFilter.append(lastComponent)
            }
        }
    }
}
