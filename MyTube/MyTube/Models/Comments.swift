//
//  File.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/07.
//

import Foundation

// MARK: - Welcome
struct Comments: Codable {
    let kind, etag, nextPageToken: String
    let pageInfo: PageInfo
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let kind: ItemKind
    let etag, id: String
    let snippet: ItemSnippet
}

enum ItemKind: String, Codable {
    case youtubeCommentThread = "youtube#commentThread"
}

// MARK: - ItemSnippet
struct ItemSnippet: Codable {
    let channelID: ChannelID
    let videoID: VideoID
    let topLevelComment: TopLevelComment
    let canReply: Bool
    let totalReplyCount: Int
    let isPublic: Bool

    enum CodingKeys: String, CodingKey {
        case channelID = "channelId"
        case videoID = "videoId"
        case topLevelComment, canReply, totalReplyCount, isPublic
    }
}

enum ChannelID: String, Codable {
    case uClehlsPFO8GlBWN1S1Bxsdw = "UClehlsPFO8glBwN1S1Bxsdw"
}

// MARK: - TopLevelComment
struct TopLevelComment: Codable {
    let kind: TopLevelCommentKind
    let etag, id: String
    let snippet: TopLevelCommentSnippet
}

enum TopLevelCommentKind: String, Codable {
    case youtubeComment = "youtube#comment"
}

// MARK: - TopLevelCommentSnippet
struct TopLevelCommentSnippet: Codable {
    let channelID: ChannelID
    let videoID: VideoID
    let textDisplay, textOriginal, authorDisplayName: String
    let authorProfileImageURL: String
    let authorChannelURL: String
    let authorChannelID: AuthorChannelID
    let canRate: Bool
    let viewerRating: ViewerRating
    let likeCount: Int
    let publishedAt, updatedAt: Date

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

enum VideoID: String, Codable {
    case jBw39PiXpo = "J-bw39piXpo"
}

enum ViewerRating: String, Codable {
    case none = "none"
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
