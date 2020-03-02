//
//  Structures.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 2/28/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

struct CharactersData: Decodable {
    let code: Int
    let status: String
    let data: CharactersDataCollection
}

struct CharactersDataCollection: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterItem]
}

struct CharacterItem: Decodable {
    let id: Int
    let name: String
    let thumbnail: ThumbnailData
    let comics: ComicsData
    
    var imageURL: String {
        return "\(thumbnail.path).\(thumbnail.ext)"
    }
}

struct ThumbnailData: Decodable {
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case ext = "extension"
    }
    let path: String
    let ext: String
}

struct ComicsData: Decodable {
    let available: Int
    let collectionURI: URL
    let items: [ComicsItem]
}

struct ComicsItem: Decodable {
    let name: String
    let resourceURI: URL
}


struct ComicsDetailsData: Decodable {
    let code: Int
    let status: String
    let data: ComicsDetailsDataCollection
}

struct ComicsDetailsDataCollection: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [ComicsDetailsItem]
}

struct ComicsDetailsItem: Decodable {
    let title: String
    let thumbnail: ThumbnailData
    let description: String?
//    let date: Date
    
    var imageURL: String {
        return "\(thumbnail.path).\(thumbnail.ext)"
    }
}
