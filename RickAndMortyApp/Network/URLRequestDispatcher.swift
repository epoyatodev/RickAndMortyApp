//
//  URLRequestDispatcher.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

struct URLRequestDispatcher {
    func doRequest<T: Decodable>(request: URLRequest) async throws -> T {
        var (data, response): (Data, URLResponse)
        
        (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HttpError.invalidResponse
        }
        
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            
            return response
        } catch {
            throw HttpError.errorDecoder(error)
        }
    }
}
