//
//  NetworkService.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func performHTTPRequest<T: Decodable>(url: String, method: String, _ completion: @escaping (Result<T, NetworkServiceError>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    
    func performHTTPRequest<T: Decodable>(url: String, method: String, _ completion: @escaping (Result<T, NetworkServiceError>) -> ()) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response else {
                completion(.failure(.noResponse))
                return }
            guard let data = data else {
                completion(.failure(.noData))
                return }
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.badResponse))
                print("Status code: ", (response as? HTTPURLResponse)?.statusCode)
                return
            }
            
            // MARK: - Decoding data and return object
            DecodeService().decodeData(data: data, completionHandler: completion)
            
        }.resume()
    }
    
}
