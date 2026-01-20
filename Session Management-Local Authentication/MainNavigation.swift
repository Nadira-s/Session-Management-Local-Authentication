//
//  MainNavigation.swift
//  Session Management-Local Authentication
//
//  Created by Nadira Seitkazy  on 20.01.2026.
//

import SwiftUI

struct MainNavigation: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            HomeScreen(path: $path)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .home:
                        HomeScreen(path: $path)
                    default:
                        EmptyView()
                    }
                }
        }
    }
}
