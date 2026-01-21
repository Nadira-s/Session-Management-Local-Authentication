import SwiftUI

struct RootView: View {

    @StateObject private var session = SessionManager()
    @State private var showSplash = true

    var body: some View {
        ZStack {

            if !showSplash {
                if session.isLoggedIn {
                    MainNavigation()
                        .environmentObject(session)
                } else {
                    AuthNavigation()
                        .environmentObject(session)
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
