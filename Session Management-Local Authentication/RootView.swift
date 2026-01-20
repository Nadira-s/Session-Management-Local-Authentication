import SwiftUI

struct RootView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var showSplash = true
    
    var body: some View {
        ZStack{
            
            if !showSplash {
                if isLoggedIn {
                    MainNavigation()
                }else {
                    AuthNavigation()
                }
            }
            
            if showSplash {
                SplashScreen {
                    withAnimation {
                        showSplash = false
                    }
                }
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}
