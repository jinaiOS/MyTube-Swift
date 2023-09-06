//
//  UserInfoModel.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/05.
//

import Foundation

struct UserInfoModel: Codable {
    let id: String
    let nickName: String
    let password: String
    let name: String
    let birth: String
    
    enum CodingKeys: String, CodingKey {
        case id = "아이디"
        case nickName = "닉네임"
        case password = "비밀번호"
        case name = "이름"
        case birth = "생일"
    }
}
