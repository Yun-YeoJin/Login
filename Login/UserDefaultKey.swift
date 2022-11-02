//
//  UserDefaultKey.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    
    let key: String
    let defaultValue: T
    let storage: UserDefaults

    var wrappedValue: T {
        get { self.storage.object(forKey: self.key) as? T ?? self.defaultValue }
        set { self.storage.set(newValue, forKey: self.key) }
    }
    
    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
            self.key = key
            self.defaultValue = defaultValue
            self.storage = storage
        }
}

class UserManager {
    
    @UserDefault(key: "token", defaultValue: nil)
    static var email: String?
    
    @UserDefault(key: "isLoggedIn", defaultValue: false)
    static var isLoggedIn: Bool
    
}
