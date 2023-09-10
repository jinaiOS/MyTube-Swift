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
    var refresh: Bool = false
    var searchText: String? = nil
    
    
    var getRequestPage: Int {
        return requestPage
    }
    
    @Published var ThumbnailList: [Thumbnails.Item] = []
    
    func getThumbnailData() {
        if refresh == true {
            reset()
        }
        Task {
            guard let result = await manager.getThumbnails(page: requestPage, searchText: searchText) else { return }
            ThumbnailList += result.items
            UserDefaultManager.sharedInstance.videoArray += result.items
            requestPage += 1
        }
    }
    
    private func reset() {
        requestPage = 0
        ThumbnailList.removeAll()
        UserDefaultManager.sharedInstance.videoArray.removeAll()
        refresh.toggle()
    }
}
