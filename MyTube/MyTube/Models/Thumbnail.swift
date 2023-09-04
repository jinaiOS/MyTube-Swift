//
//  Thumbnail.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

struct Thumbnail: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let snippet: Snippet
    }
    
    struct Snippet: Codable {
        let publishedAt: String
        let title: String
        let description: String
        let thumbnails: ThumbnailSize
        let channelTitle: String
        let liveBroadcastContent: String
        let publishTime: String
    }
    
    struct ThumbnailSize: Codable {
        let medium: Thumbnails
        let high: Thumbnails
    }
    
    struct Thumbnails: Codable {
        let url: String
        let width: Int
        let height: Int
    }
}
