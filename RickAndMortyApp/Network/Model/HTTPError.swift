//
//  HTTPError.swift
//  RickAndMortyApp
//
//  Created by Enrique Poyato Ortiz on 23/9/24.
//

import Foundation

enum HttpError: Error {
    case invalidURL
    case invalidResponse
    case errorDecoder(Error)
}
