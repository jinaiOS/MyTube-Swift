//
//  Thumbnail.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

struct Thumbnails: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let id: ID
        let snippet: Snippet
    }
    
    struct ID: Codable {
        let kind: String
        let videoId: String // 비디오 아이디
    }
    
    struct Snippet: Codable {
        let publishedAt: String
        let channelId: String // 구독
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
