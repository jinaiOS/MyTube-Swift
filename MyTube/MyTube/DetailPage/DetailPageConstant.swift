//
//  detailPageConstant.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/04.
//

// 유튜브에서 데이터 크롤링을 할 때 사용하고자 하는 모델 파일
import Foundation

struct Constant {
    static var API_KEY = ""
    static var PLAYLIST_ID = "PL1nP78IpsXsOsYwbxcr7Bhq38Ap4QRZU7"
    static var API_URL = "https://youtube.googleapis.com/youtube/v3/playlists?part=snippet&id=\(Constant.PLAYLIST_ID)&key=\(Constant.API_KEY)"
}
