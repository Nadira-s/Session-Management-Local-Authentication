//
//  AuthNavigation.swift
//  Session Management-Local Authentication
//
//  Created by Nadira Seitkazy  on 20.01.2026.
//
import SwiftUI

struct AuthNavigation: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            LoginScreen(path: $path)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .login:
                        LoginScreen(path:$path)
                    case .signup:
                        SignUpScreen(path: $path)
                    default:
                        EmptyView()
                    }
                }
        }
    }
}
