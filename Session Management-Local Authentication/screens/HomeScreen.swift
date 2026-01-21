//
//  HomeScreen.swift
//  Authentication Feature
//
//  Created by Nadira Seitkazy  on 14.01.2026.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var path: NavigationPath
    @EnvironmentObject var session: SessionManager
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(spacing:30){
            Text(Strings.homeTitle)
            PrimaryButton(title: "Logout"){
                session.logout()
            }
            PrimaryButton(title: "Delete account"){
                showDeleteAlert = true
            }
            .alert("Delete account?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {}
                
                Button("Delete", role: .destructive) {
                    UserDefaultsManager.clearAll()
                    session.deleteAccount()
                }
            } message: {
                Text("This action cannot be undone")
            }
        }
        .padding(.horizontal)
    }
       }

enum UserDefaultsManager {
    static func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
}

#Preview {
    RootView()
}
