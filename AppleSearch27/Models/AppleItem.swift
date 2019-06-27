//
//  AppleItem.swift
//  AppleSearch27
//
//  Created by Drew Seeholzer on 6/27/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation

struct TopLevelJSON: Codable {
    let results: [AppleItem]
}

struct AppleItem: Codable {
    
    let track: String
    let artist: String
    let album: String?
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case track = "trackName"
        case artist = "artistName"
        case album = "collectionName"
        case imageURL = "artworkUrl30"
    }
    
}


