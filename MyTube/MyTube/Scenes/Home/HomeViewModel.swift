//
//  HomeViewModel.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    let manager = YoutubeManger.shared
    
    @Published var ThumbnailList: Thumbnails?
    
    func getThumbnailData(page: Int) {
        Task {
            let result = await manager.getThumbnails(page: page)
            ThumbnailList = result
        }
    }
    
//    func getVideoUrl(url: String) -> String? {
//        // 정규식 패턴
//        let pattern = #"\/vi\/([A-Za-z0-9_-]+)\/"#  // YouTube 동영상 ID를 추출하는 패턴
//        if let range = url.range(of: pattern, options: .regularExpression) {
//            let videoID = url[range].replacingOccurrences(of: "/vi/", with: "").replacingOccurrences(of: "/", with: "")
//            return videoID
//        } else {
//            print("YouTube Video ID를 찾을 수 없습니다.")
//            return nil
//        }
//    }
}
