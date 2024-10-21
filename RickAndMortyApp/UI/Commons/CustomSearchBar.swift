//
//  CustomSearchBar.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import SwiftUI

struct CustomSearchBar: View {
    @FocusState private var isFocused: Bool
    @Binding var searchText: String
    var body: some View {
        TextField("", text: $searchText)
            .padding(.leading, 25)
        
            .overlay(alignment: .leading) {
                HStack(spacing: 4) {
                    Image(systemName: "magnifyingglass")
                    Text(searchText.isEmpty ? "Search..." : "")
                    
                }
                .foregroundStyle(.secondary)
                .onTapGesture {
                    isFocused = true
                }
            }
            .overlay(alignment: .trailing) {
                if !searchText.isEmpty {
                    Image(systemName: "xmark")
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            searchText = ""
                        }
                }
                
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(.secondary.opacity(0.1))
            .shadow(radius: 5, x: 5, y: 5)
            .clipShape(.rect(cornerRadius: 6))
            .padding(.horizontal)
            .focused($isFocused)
        
    }
}

#Preview {
    CustomSearchBar(searchText: .constant(""))
}
