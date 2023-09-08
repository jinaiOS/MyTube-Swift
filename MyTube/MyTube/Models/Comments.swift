//
//  File.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/07.
//

import Foundation

struct Comments: Codable {
    let id: String
    let snippet: CommentSnippet
}

struct CommentSnippet: Codable {
    let topLevelComment: CommentDetail
}

struct CommentDetail: Codable {
    let textDisplay: String
    let authorDisplayName: String
    let authroProfileImageUrl: String
}
