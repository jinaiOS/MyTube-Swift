//
//  YoutubeManger.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation
import Alamofire

final class YoutubeManger {
    static let shared = YoutubeManger()
    private init() { }
    
    func getThumbnails(page: Int, searchText: String?) async -> Thumbnails? {
        var params = [
            "part": "snippet",
            "type": "video",
            "page": "\(page)",
            "maxResults": "20",
            "key": TEST4_KEY
        ]
        
        if let searchText = searchText {
            params["q"] = searchText
        }
        
        let dataTask = AF.request(ThumbNailUrl, method: .get, parameters: params)
            .serializingDecodable(Thumbnails.self)
        
        switch await dataTask.result {
        case .success(let result):
            return result
            
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
  
    func getComments(from videoId: String, completion: @escaping (Result<Comments, Error>) -> Void) {
        let params = [
            "textFormat": "plainText",
            "part": "snippet",
            "videoId": "\(videoId)",
            "maxResults": "50",
            "key": TEST4_KEY
        ]
        
        AF.request(CommentURL, method: .get, parameters: params).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let jsonData = try decoder.decode(Comments.self, from: data!)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getProfileThumbnail(channelID: String) async -> ProfileThumbnail? {
        let params = [
            "part": "snippet,contentDetails,statistics",
            "id": channelID,
            "fields": "items/snippet/thumbnails",
            "key": TEST4_KEY
        ]
        let dataTask = AF.request(ChannelURL, method: .get, parameters: params)
            .serializingDecodable(ProfileThumbnail.self)
            
        switch await dataTask.result {
        case .success(let result):
            return result
            
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getChannelInfo(channelID: String) async -> Channel? {
        let params = [
            "part": "snippet,contentDetails,statistics",
            "id": channelID,
            "key": TEST4_KEY
        ]
        
        let dataTask = AF.request(ChannelURL, method: .get, parameters: params)
            .serializingDecodable(Channel.self)
            
        switch await dataTask.result {
        case .success(let result):
            return result
            
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
}
