//
//  SessionManager.swift
//  Session Management-Local Authentication
//
//  Created by Nadira Seitkazy  on 21.01.2026.
//

import SwiftUI

enum LoginResult {
    case success
    case userNotFound
    case wrongPassword
}

final class SessionManager: ObservableObject{
    @Published var isLoggedIn: Bool = false
    
    init() {
        checkSession()
    }
    
    func checkSession() {
        isLoggedIn = UserStorage.shared.getUser() != nil
    }
    
    func signup(name: String, email: String, password: String) -> Bool {
        if UserStorage.shared.getUser() != nil {
            return false
        }
        let user  = User(name: name, email: email, password: password)
        UserStorage.shared.save(user: user)
        isLoggedIn = true
        return true
    }
    func login(email: String, password: String) -> LoginResult {

        guard let user = UserStorage.shared.getUser() else {
            return .userNotFound
        }

        if user.password != password {
            return .wrongPassword
        }

        isLoggedIn = true
        return .success
    }
    func logout() {
        isLoggedIn = false
    }
    func deleteAccount() {
        UserStorage.shared.deleteUser()
        isLoggedIn = false
    }
}
