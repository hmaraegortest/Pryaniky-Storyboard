//
//  ImageDownloader.swift
//  PryanikyStoryboard
//
//  Created by Egor on 09.10.2020.
//

import Foundation

protocol ImageDownloaderProtocol: AnyObject {
    func downloadImage(stringURL: String, completionHandler:
        @escaping (Data) -> ())
}

class ImageDownloader: ImageDownloaderProtocol {
    
    func downloadImage(stringURL: String, completionHandler:
        @escaping (Data) -> ()) {
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            completionHandler(imageData)
        }
    }
}
