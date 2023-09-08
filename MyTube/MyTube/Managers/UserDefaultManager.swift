//
//  UserDefaultManager.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/05.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
        
    private let userDefaults = UserDefaults.standard
    private let contactKey = "Root"
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var archiveURL: URL
    var userInfo: UserInfoModel?
    
    init() {
        archiveURL = Bundle.main.url(forResource: "User", withExtension: "plist")!
    }
    
    // MARK: userDefaults
    
    func fetchContacts() -> [UserInfoModel] {
        guard let data = userDefaults.object(forKey: contactKey) as? Data else { return [] }
        guard let contacts = try? JSONDecoder().decode([UserInfoModel].self, from: data) else { return [] }
        return contacts
    }
    
    func save(contact: UserInfoModel) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefaults.setValue(data, forKey: contactKey)
    }
    
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefaults.setValue(data, forKey: contactKey)
    }
    
    // MARK: plist
    
    func fetchFromFile() -> [UserInfoModel] {
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let contacts = try? PropertyListDecoder().decode([UserInfoModel].self, from: data) else { return [] }
        return contacts
        
    }
    
    func requestLogin(id: String, pw: String) -> Bool {
        var contacts = fetchFromFile()
        
        for i in contacts {
            if i.id == id && i.password == pw {
                print("login complete")
                userInfo = i
                return true
            }
        }
        print("login fail")
        return false
    }
    
    func saveToFile(with contact: UserInfoModel, index: Int? = nil) {
        var contacts = fetchFromFile()
        if let index = index {
            contacts[index] = contact
        } else {
            contacts.append(contact)
        }

        guard let data = try? PropertyListEncoder().encode(contacts) else {
            return
        }
        
        try? data.write(to: archiveURL, options: .noFileProtection)
        print(fetchFromFile())
    }
    
    func deleteFromFile(at index: Int) {
        var contacts = fetchFromFile()
        contacts.remove(at: index)
        
        guard let data = try? PropertyListEncoder().encode(contacts) else {
            return
        }
    
        try? data.write(to: archiveURL, options: .noFileProtection)
        print(fetchFromFile())
    }
    
    func saveCurrentVideo(videoId: String) {
        userDefaults.set(videoId, forKey: "currentVideoId")
    }
}
