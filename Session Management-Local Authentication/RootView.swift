import SwiftUI

struct RootView: View {
    @State private var path = NavigationPath()
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                LoginScreen(path: $path)
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .login:
                            LoginScreen(path: $path)
                        case .signup:
                            SignUpScreen(path: $path)
                        case .home:
                            HomeScreen(path: $path)
                        }
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
