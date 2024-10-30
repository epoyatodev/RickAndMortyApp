//
// EpisodesView.swift
//
// Created by Enrique Poyato Ortiz.
// Linkedin: https://www.linkedin.com/in/enrique-poyato-ortiz-%EF%A3%BF-7447b32$
// Copyright © 2024 Enrique P. Ortiz. All rights reserved
//

import SwiftUI

struct EpisodesView: View {
    @State private var episodesViewModel: EpisodesViewModel = .init()
    @State var edge = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets
    var body: some View {
        NavigationStack {
            List(episodesViewModel.episodesModelLogic.episodes) { episode in
                Text(episode.name)
                    .padding(.bottom, episode == episodesViewModel.episodesModelLogic.episodes.last ? edge!.bottom + 15 : 0)
            }
            .navigationTitle("Episodes")
            .listStyle(.plain)
        }
        .task {
            await episodesViewModel.episodesModelLogic.fetchEpisodes()
        }
    }
}

#Preview {
    EpisodesView()
}
