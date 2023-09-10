//
//  UserDefaultManager.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/05.
//

import Foundation

class UserDefaultManager {
    
    static let sharedInstance = UserDefaultManager()
    
    var userInfo : UserInfoModel?
    
    var userList = [UserInfoModel]() {
        didSet {
            self.saveUserInfo()
        }
    }
    
    var seeArray : [String] = []
    var subscribeArray : [String] = []
    var likeArray : [String] = []
    var disLikeArray : [String] = []
    var videoArray : [Thumbnails.Item] = []

    func saveUserInfo() {
        let data = self.userList.map {
            [
                "id": $0.id,
                "nickName": $0.nickName,
                "password": $0.password,
                "name": $0.name,
                "birth": $0.birth
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "userList")
        print(userList)
    }
    
    func loadUsers() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "userList") as? [[String: Any]] else { return }

        self.userList = data.compactMap {
            guard let id = $0["id"] as? String else { return nil }
            guard let nickName = $0["nickName"] as? String else { return nil }
            guard let password = $0["password"] as? String else { return nil }
            guard let name = $0["name"] as? String else { return nil }
            guard let birth = $0["birth"] as? String else { return nil }
            return UserInfoModel(id: id, nickName: nickName, password: password, name: name, birth: birth)
        }
    }
    
    func requestLogin(id: String, pw: String) -> Bool {
       for i in userList {
           if i.id == id && i.password == pw {
               print("login complete")
               userInfo = i
               return true
           }
        }
        print("login fail")
        return false
    }
    
    func checkIDDoubleCheck(id: String) -> Bool {
        for i in userList {
            if i.id == id {
                return true
            }
        }
        return false
    }
    
    func editMembership(id: String, nickName: String, pw: String, name: String, birth: String) {
        for i in 0..<userList.count {
            if userList[i].id == userInfo?.id {
                userList[i] = UserInfoModel(id: id, nickName: nickName, password: pw, name: name, birth: birth)
                userInfo = UserInfoModel(id: id, nickName: nickName, password: pw, name: name, birth: birth)
            }
        }
    }
    
    func saveCurrentVideo(videoId: String) {
        seeArray.append(videoId)
        for i in seeArray {
            if i == "" {
                seeArray.remove(at: 0)
            }
        }
        seeArray = removeDuplicate(seeArray)
       UserDefaults.standard.set(seeArray, forKey: "currentVideoId")
    }
    
    func saveSubscribe(channelID: String) {
        subscribeArray.append(channelID)
        for i in subscribeArray {
            if i == "" {
                subscribeArray.remove(at: 0)
            }
        }
        subscribeArray = removeDuplicate(subscribeArray)
       UserDefaults.standard.set(subscribeArray, forKey: "subscribeChannelID")
    }
    
    func deleteSubscribe(channelID: String) {
        subscribeArray = subscribeArray.filter  { (element) -> Bool in
           return element != channelID
       }
        for i in subscribeArray {
            if i == "" {
                subscribeArray.remove(at: 0)
            }
        }
        subscribeArray = removeDuplicate(subscribeArray)
       UserDefaults.standard.set(subscribeArray, forKey: "subscribeChannelID")
    }
    
    func saveLikeVido(videoId: String) {
        likeArray.append(videoId)
        for i in likeArray {
            if i == "" {
                likeArray.remove(at: 0)
            }
        }
        likeArray = removeDuplicate(likeArray)
       UserDefaults.standard.set(likeArray, forKey: "likeVideoID")
    }
    
    func deleteLikeVido(videoId: String) {
        likeArray = likeArray.filter  { (element) -> Bool in
            return element != videoId
        }
        for i in likeArray {
            if i == "" {
                likeArray.remove(at: 0)
            }
        }
        likeArray = removeDuplicate(likeArray)
       UserDefaults.standard.set(likeArray, forKey: "likeVideoID")
    }
    
    func saveDisLikeVido(videoId: String) {
        disLikeArray.append(videoId)
        for i in disLikeArray {
            if i == "" {
                disLikeArray.remove(at: 0)
            }
        }
        disLikeArray = removeDuplicate(disLikeArray)
       UserDefaults.standard.set(disLikeArray, forKey: "dislikeVideoID")
    }
    
    func deleteDisLikeVido(videoId: String) {
        disLikeArray = disLikeArray.filter  { (element) -> Bool in
            return element != videoId
        }
        for i in disLikeArray {
            if i == "" {
                disLikeArray.remove(at: 0)
            }
        }
        disLikeArray = removeDuplicate(disLikeArray)
       UserDefaults.standard.set(disLikeArray, forKey: "dislikeVideoID")
    }
    
    func removeDuplicate (_ array: [String]) -> [String] {
        var removedArray = [String]()
        for i in array {
            if removedArray.contains(i) == false {
                removedArray.append(i)
            }
        }
        return removedArray
    }
}
