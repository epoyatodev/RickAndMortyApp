//
//  String+Extensions.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 24/9/24.
//

import Foundation

extension String {
    func extractNumberOfPageURL() -> Int? {
        guard let urlComponents = URLComponents(string: self), let pageValue = urlComponents.queryItems?.first(where: { $0.name == "page" })?.value else { return nil }
        return Int(pageValue)
    }
}
