//
//  CharactersFiltersView.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 10/10/24.
//

import SwiftUI

struct CharactersFiltersView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(CharactersViewModel.self) private var charactersViewModel
    @Namespace var namespace
    var body: some View {
        @Bindable var viewModel = charactersViewModel
        VStack {
            Text("Filter your characters")
                .bold()
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                // MARK: Gender
                Text("Gender")
                CustomPicker(selected: $viewModel.charactersLogic.selectedGender)
                
                // MARK: Species
                Text("Species")
                CustomPicker(selected: $viewModel.charactersLogic.selectedSpecies)
                
                // MARK: Status
                Text("Status")
                CustomPicker(selected: $viewModel.charactersLogic.selectedStatus)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .bold()
            
            Spacer()

            HStack {
                Button("Apply") {
                    Task {
                        await viewModel.charactersLogic.fetchCharacters()
                    }
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.blue.opacity(0.8))
                .clipShape(.capsule)
                .foregroundStyle(.white)
                
                
                Button("Clear") {
                    NotificationCenter.default.post(name: .clearFilters, object: nil)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.red.opacity(0.8))
                .clipShape(.capsule)
                .foregroundStyle(.white)
            
            }
            .padding(.vertical)
            
            
        }
        .padding()
        .presentationDetents([.medium])
        .presentationCornerRadius(20)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.5)
            .ignoresSafeArea()
        
        CharactersFiltersView()
            .frame(maxWidth: .infinity)
            .frame(height: 400)
            .background()
            .clipShape(.rect(cornerRadius: 10))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .environment(CharactersViewModel(charactersLogic: .init(charactersService: CharactersServiceTest()), episodesLogic: .init(episodesService: EpisodesServiceTest())))
    }
    
}


