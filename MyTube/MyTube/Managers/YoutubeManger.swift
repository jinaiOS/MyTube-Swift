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
    
    
    
    
    func getThumbnail(page: Int) async {
        let params = [
            "part": "snippet",
            "type": "video",
            "page": "\(page)",
            "maxResults": "20",
            "key": key
        ]
        
        let dataTask = AF.request(thumbNailUrl, method: .get, parameters: params)
            .serializingDecodable(Thumbnail.self)
        
        switch await dataTask.result {
        case .success(let result):
            print("======> result: \(result)")
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
