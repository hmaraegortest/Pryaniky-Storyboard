//
//  NetworkServiceError.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import Foundation

enum NetworkServiceError: Error {
    case badURL
    case noResponse
    case noData
    case jsonDecoding
    case networkError
    case badResponse
}
