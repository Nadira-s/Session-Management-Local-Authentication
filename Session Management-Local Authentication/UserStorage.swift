//
//  UserStorage.swift
//  Session Management-Local Authentication
//
//  Created by Nadira Seitkazy  on 20.01.2026.
//

import Foundation

final class UserStorage {
    static let shared = UserStorage()
    private init() {}
    
    private let userKey = "savedUser"
    func save(user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }
    
    func getUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userKey),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil
        }
        return user
    }
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}

