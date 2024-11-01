//
//  TabBarView.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 14/10/24.
//

import SwiftUI

struct TabBarView: View {
    /// A tabBarViewModel environment propertie
    @Environment(TabBarViewModel.self) var tabBarViewModel
    @State var charactersViewModel: CharactersViewModel = .init()
    @State private var selected: TabItem = .characters
    init () {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        @Bindable var tabBarViewModel = tabBarViewModel
        
        TabView(selection: $selected) {
            Tab(value: .characters) {
                CharactersView()
                    .environment(charactersViewModel)
            }
            Tab(value: .episodes) {
                EpisodesView()
            }
            
            Tab(value: .favorites) {
                FavoritesView()
                    .environment(charactersViewModel)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0){
            CustomTabBar(selected: $selected, showTabBar: $tabBarViewModel.showTabBar)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    TabBarView()
        .environment(TabBarViewModel())
}


