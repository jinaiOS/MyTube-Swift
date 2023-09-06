//
//  String+.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

extension String {
    func getVideoID() -> String? {
        // 정규식 패턴
        let pattern = #"\/vi\/([A-Za-z0-9_-]+)\/"#  // YouTube 동영상 ID를 추출하는 패턴
        if let range = self.range(of: pattern, options: .regularExpression) {
            let videoID = self[range].replacingOccurrences(of: "/vi/", with: "").replacingOccurrences(of: "/", with: "")
            return videoID
        } else {
            print("YouTube Video ID를 찾을 수 없습니다.")
            return nil
        }
    }
}
