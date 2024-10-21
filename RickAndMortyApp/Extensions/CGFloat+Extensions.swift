//
//  CGFloat+Extensions.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 14/10/24.
//

import Foundation
import SwiftUI

extension CGFloat {
    static var screenWidth: CGFloat {
        if let screenWidth = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.width {
            return screenWidth
        }
        
        return .zero
    }
    
    static var screenHeight: CGFloat {
        if let screenHeight = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.height {
            return screenHeight
        }
        
        return .zero
    }
}
