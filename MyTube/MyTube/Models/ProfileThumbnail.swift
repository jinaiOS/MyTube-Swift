//
//  ProfileThumbnail.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

struct ProfileThumbnail: Codable {
    let items: [Item]?

    struct Item: Codable {
        let snippet: Snippet
    }

    struct Snippet: Codable {
        let thumbnails: Thumbnails
    }

    struct Thumbnails: Codable {
        let medium: Thumbnail
        let high: Thumbnail
    }
    
    struct Thumbnail: Codable {
        let url: String
        let width: Int
        let height: Int
    }
}
