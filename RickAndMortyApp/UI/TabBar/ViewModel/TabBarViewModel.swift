//
//  TabBarViewModel.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 14/10/24.
//

import Foundation
import SwiftUI

@Observable
final class TabBarViewModel {
    var originValueScroll: CGFloat? = nil
    var offsetY: CGFloat = 0
    var showTabBar: Bool = true
    
    
    func showOrHideTabBar(oldValue: CGFloat, newValue: CGFloat, showProgress: Bool) {
        let new = newValue + (-(originValueScroll ?? 0))
        let old = oldValue + (-(originValueScroll ?? 0) )
        if originValueScroll == nil && newValue != 0 {
            self.originValueScroll = newValue
        }
        if let _ = originValueScroll {
            self.offsetY = new
        }
        
        if self.offsetY > old && old > 0 {
            withAnimation {
                self.showTabBar = false
            }
        } else {
            withAnimation {
                if showProgress {
                    self.showTabBar = false
                } else {
                    self.showTabBar = true
                }
            }
        }
    }
}
