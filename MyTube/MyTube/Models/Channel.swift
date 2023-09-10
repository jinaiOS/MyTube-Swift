//
//  Channel.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

struct Channel: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let id: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        let statistics: Statistics
    }
    
    struct Snippet: Codable {
        let title: String
        let description: String
        let customUrl: String
        let publishedAt: String
    }
    
    struct ContentDetails: Codable {
        let relatedPlaylists: RelatedPlaylists
    }
    
    struct Statistics: Codable {
        let viewCount: String
        let subscriberCount: String
        let hiddenSubscriberCount: Bool
        let videoCount: String
    }
    
    struct RelatedPlaylists: Codable {
        let likes: String
        let uploads: String
    }
}
