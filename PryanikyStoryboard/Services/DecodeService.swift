//
//  DecodeService.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import Foundation

class DecodeService {
    
    func decodeData<T: Decodable>(data: Data, completionHandler:
        @escaping (Result<T, NetworkServiceError>) -> ()) {
        
        // TODO: delete after debugging
        
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        print("json\n", json)
//                    } catch {
//                        print("json error")
//                    }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
            do {
                let daylyWeather = try decoder.decode(T.self, from: data)
                completionHandler(.success(daylyWeather))
            } catch {
                completionHandler(.failure(.jsonDecoding))
            }
        
    }
    
}
