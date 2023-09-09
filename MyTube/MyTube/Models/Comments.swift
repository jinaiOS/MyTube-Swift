//
//  Comments.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/07.
//

import Foundation

struct Comments: Codable {
    let item: [Item]
    
    // MARK: - Item
    struct Item: Codable {
        let snippet: ItemSnippet
    }

    // MARK: - ItemSnippet
    struct ItemSnippet: Codable {
        let channelID, videoID: String?
        let topLevelComment: TopLevelComment
        let canReply: Bool?
        let totalReplyCount: Int?
        let isPublic: Bool?

        enum CodingKeys: String, CodingKey {
            case channelID = "channelId"
            case videoID = "videoId"
            case topLevelComment, canReply, totalReplyCount, isPublic
        }
    }

    // MARK: - TopLevelComment
    struct TopLevelComment: Codable {
        let kind, etag, id: String?
        let snippet: TopLevelCommentSnippet
    }

    // MARK: - TopLevelCommentSnippet
    struct TopLevelCommentSnippet: Codable {
        let channelID, videoID, textDisplay, textOriginal: String?
        let authorDisplayName: String?
        let authorProfileImageURL: String?
        let authorChannelURL: String?
        let authorChannelID: AuthorChannelID
        let canRate: Bool?
        let viewerRating: String?
        let likeCount: Int?
        let publishedAt, updatedAt: Date?

        enum CodingKeys: String, CodingKey {
            case channelID = "channelId"
            case videoID = "videoId"
            case textDisplay, textOriginal, authorDisplayName
            case authorProfileImageURL = "authorProfileImageUrl"
            case authorChannelURL = "authorChannelUrl"
            case authorChannelID = "authorChannelId"
            case canRate, viewerRating, likeCount, publishedAt, updatedAt
        }
    }

    // MARK: - AuthorChannelID
    struct AuthorChannelID: Codable {
        let value: String
    }

    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }

}

