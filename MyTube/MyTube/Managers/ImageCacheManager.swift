//
//  ImageCacheManager.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import Alamofire

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() { }
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func loadImage(url: String) async -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        if let image = cachedImage(url: url) {
            return image
        }
        let dataTask = AF.request(url, method: .get)
            .serializingData()
        
        switch await dataTask.result {
        case .success(let data):
            let image = UIImage(data: data)
            cachingImage(url: url, image: image)
            return image
            
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func cachingImage(url: URL, image: UIImage?) {
        guard let image = image else { return }
        cache.setObject(image, forKey: url as NSURL)
    }
    
    private func cachedImage(url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }
}
