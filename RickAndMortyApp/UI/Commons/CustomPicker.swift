//
//  CustomPicker.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 14/10/24.
//

import SwiftUI

protocol PickerOption: CaseIterable, RawRepresentable, Hashable where RawValue == String {}

struct CustomPicker<T: PickerOption>: View {
    @Binding var selected: T
    @Namespace var namespace
    var options: [T]
    
    init(selected: Binding<T>) {
        self._selected = selected
        self.options = Array(T.allCases)
    }
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(options, id: \.rawValue) { option in
                        ZStack {
                            
                            if option == selected {
                                Capsule()
                                    .fill(Color.green)
                                    .mask {
                                        Capsule()
                                    }
                                    .matchedGeometryEffect(id: "background", in: namespace)
                                
                            }
                            
                            Text(option.rawValue)
                                .foregroundStyle(option == selected ? .white : .black)
                                .font(.system(size: 12))
                                .padding(10)
                            
                        }
                        .frame(width: 100, height: 35)
                        
                        .onTapGesture {
                            withAnimation(.smooth) {
                                if self.selected != option {
                                    self.selected = option
                                    proxy.scrollTo(option.rawValue, anchor: .center)
                                }
                                
                            }
                            impact(style: .medium)
                        }
                    }
                }
                
            }
            .clipShape(Capsule())
            .onReceive(NotificationCenter.default.publisher(for: .clearFilters)) { _ in
                withAnimation {
                    self.selected = options.first!
                    proxy.scrollTo(selected.rawValue, anchor: .center)
                }
            }
            .onAppear {
                proxy.scrollTo(selected.rawValue)
            }
            
        }
        .overlay {
            Capsule()
                .stroke(Color.black.opacity(0.6), lineWidth: 1)
        }
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.impactOccurred()
    }
}


