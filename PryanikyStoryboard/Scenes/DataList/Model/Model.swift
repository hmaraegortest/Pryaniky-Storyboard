//
//  Model.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import Foundation

struct PryanikyStaticJson: Decodable {
    let data: [Element]
    let view: [String]
}

struct Element: Decodable {
    let name: String
    let data: Any
    
    enum CodingKeys: String, CodingKey {
        case name
        case data
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            name = try container.decode(String.self, forKey: .name)
            
            if name == "hz", let hzData = try? container.decode(HzData.self, forKey: .data) {
                data = hzData
            } else if name == "picture", let pictureData = try? container.decode(PictureData.self, forKey: .data) {
                data = pictureData
            } else if name == "selector", let selectorData = try? container.decode(SelectorData.self, forKey: .data) {
                data = selectorData
            } else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
            }
        }
    }
    
}

struct HzData: Decodable {
    let text: String
}

struct PictureData: Decodable {
    let url: String
    let text: String
}

struct SelectorData: Decodable {
    let selectedId: Int
    let variants: [Variant]
}

struct Variant: Decodable {
    let id: Int
    let text: String
}


