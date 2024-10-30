//
// EpisodesModelLogic.swift
//
// Created by Enrique Poyato Ortiz.
// Linkedin: https://www.linkedin.com/in/enrique-poyato-ortiz-%EF%A3%BF-7447b3200/
// Copyright © 2024 Enrique P. Ortiz. All rights reserved
//

import Foundation

@Observable
final class EpisodesModelLogic {
    private var episodesService: EpisodesServiceProtocol
    var episodes: [Episode] = []
    
    init(episodesService: EpisodesServiceProtocol = EpisodesService()) {
        self.episodesService = episodesService
    }
    
    @MainActor
    func fetchEpisodes() async {
        do {
            self.episodes = try await episodesService.fetchEpisodes(filter: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
}
