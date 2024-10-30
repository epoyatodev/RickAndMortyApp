//
// EpisodesViewModel.swift
//
// Created by Enrique Poyato Ortiz.
// Linkedin: https://www.linkedin.com/in/enrique-poyato-ortiz-%EF%A3%BF-7447b3200/
// Copyright © 2024 Enrique P. Ortiz. All rights reserved
//

import Foundation

@Observable
final class EpisodesViewModel {
    var episodesModelLogic: EpisodesModelLogic
    
    init(episodesModelLogic: EpisodesModelLogic = .init()) {
        self.episodesModelLogic = episodesModelLogic
    }
}
