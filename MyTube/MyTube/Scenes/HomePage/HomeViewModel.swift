//
//  HomeViewModel.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    private let manager = YoutubeManger.shared
    private var requestPage: Int = 0
    let display: Int = 20
    
    var getRequestPage: Int {
        return requestPage
    }
    
    @Published var ThumbnailList: [Thumbnails.Item] = []
    @Published var searchList: [Thumbnails.Item] = []
    
    func getThumbnailData() {
        Task {
            guard let result = await manager.getThumbnails(page: requestPage) else { return }
            ThumbnailList += result.items
            requestPage += 1
        }
    }
    
    func getSearchThumbnailData(searchText: String) {
        
    }
}
