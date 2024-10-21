//
//  InfoManager.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

enum DictionaryKey: String {
    case host = "HOST_URL"
}

final class InfoManager {
    static let shared = InfoManager()
    
    private init() {}
    
    func getUrlString(forKey key: DictionaryKey) -> String? {
        if let infoDictionary = Bundle.main.infoDictionary,
           let urls = infoDictionary["urls"] as? [String: Any],
           let urlString = urls[key.rawValue] as? String {
            return urlString
        }
        return nil
    }
}
