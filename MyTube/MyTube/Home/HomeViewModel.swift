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
}
