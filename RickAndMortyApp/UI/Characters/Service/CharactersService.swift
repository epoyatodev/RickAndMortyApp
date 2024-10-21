//
//  CharactersService.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

protocol CharactersServiceProtocol {
    var responseInfo: InfoResult? { get }
    mutating func fetchCharacters(with name: String, with status: Status, with gender: Gender, with species: Species, loadMore: Bool) async throws -> [Character]
}
extension CharactersServiceProtocol {
    var responseInfo: InfoResult? { nil }
}

struct CharactersService: CharactersServiceProtocol {
    var responseInfo: InfoResult?
    
    mutating func fetchCharacters(with name: String, with status: Status, with gender: Gender, with species: Species, loadMore: Bool) async throws -> [Character] {
        guard let baseURL = InfoManager.shared.getUrlString(forKey: .host) else { throw HttpError.invalidURL }
        
        let urlRequest = try RequestBuilder(
            endpoint: Endpoint.characters.rawValue,
            baseURL: baseURL,
            method: .get,
            queryItems: [
                .init(name: "name", value: name),
                .init(name: "status", value: status != .all ? status.rawValue : ""),
                .init(name: "gender", value: gender != .all ? gender.rawValue : ""),
                .init(name: "species", value: species != .all ? species.rawValue : ""),
                .init(name: "page", value: loadMore ? responseInfo?.next?.extractNumberOfPageURL()?.description: "")
            ])
            .buildURLRequest()
        let response = try await (URLRequestDispatcher().doRequest(request: urlRequest) as CharacterResponse)
        self.responseInfo = response.info
        
        return response.results.map(\.toCharacters)
    }
}
