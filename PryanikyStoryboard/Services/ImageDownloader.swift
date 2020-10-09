//
//  ImageDownloader.swift
//  PryanikyStoryboard
//
//  Created by Egor on 09.10.2020.
//

import Foundation

class ImageDownloader {
    
    private init() { }
    
    static func downloadImage(stringURL: String, completionHandler:
        @escaping (Data) -> ()) {
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            completionHandler(imageData)
        }
    }
}
