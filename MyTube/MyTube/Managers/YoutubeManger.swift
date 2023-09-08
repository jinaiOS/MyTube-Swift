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
            "key": TEST2_KEY
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
}
