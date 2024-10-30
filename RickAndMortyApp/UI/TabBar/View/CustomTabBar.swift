//
//  CustomTabBar.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 14/10/24.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selected: TabItem
    @Binding var showTabBar: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.white)
                .frame(height: 48)
                .shadow(radius: 5)
            
            HStack {
                ForEach(TabItem.allCases, id: \.rawValue) { item in
                    VStack(spacing: 5) {
                        Image(systemName: item.image)
                            .font(.title2.bold())
                            .foregroundColor(self.selected == item ? .blue : .secondary)
                        Text(item.rawValue)
                            .font(.caption)
                            .foregroundColor(self.selected == item ? .blue : .secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        self.selected = item
                        NotificationCenter.default.post(name: .itemTabbarTap, object: nil, userInfo: ["tabItem": item])
                    }
                }
            }
        }
        .offset(y: showTabBar ? 0 : 100)
        .transition(.move(edge: .bottom))
    }
}

#Preview {
    CustomTabBar(selected: .constant(.characters), showTabBar: .constant(true))
}
