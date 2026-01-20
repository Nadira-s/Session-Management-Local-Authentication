//
//  HomeScreen.swift
//  Authentication Feature
//
//  Created by Nadira Seitkazy  on 14.01.2026.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var path: NavigationPath 
    
    var body: some View {
        Text(Strings.homeTitle)
    }
    
}

#Preview {
    RootView()
}
