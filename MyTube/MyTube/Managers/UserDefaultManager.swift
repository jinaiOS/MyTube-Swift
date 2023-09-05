//
//  UserDefaultManager.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/05.
//

import Foundation

struct UserdefaultManager {
    static let shared = UserdefaultManager()
    
    func requestJoinMembership(id: String, nickName: String, password: String, name: String, birth: String) {
        guard let url = Bundle.main.url(forResource: "User", withExtension: "plist") else {
            return
        }
        
        let join = UserInfoModel(id: id, nickName: nickName, password: password, name: name, birth: birth)
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
          let data = try encoder.encode(join)
          try data.write(to: url)
        } catch {
          // Handle error
          print(error)
        }
    }
    
    func requestUserInfoList() {
        guard let url = Bundle.main.url(forResource: "User", withExtension: "plist") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([UserInfoModel].self, from: data)
            
            print(result)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        
        } catch {
            print(error.localizedDescription)
        }
    }
}
