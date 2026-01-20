import SwiftUI

struct SplashScreen: View {
    let onFinish: () -> Void
    
    @State private var progress: Double = 0   // start empty
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                
                ProgressView(value: progress, total: 1)
                    .progressViewStyle(.linear)
                    .padding(.horizontal, 40)
            }
        }
        .onAppear {
            startProgress()
        }
    }
    
    func startProgress() {
        let duration: Double = 3
        let interval: Double = 0.02   
        let increment = interval / duration
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            progress += increment
            if progress >= 1 {
                timer.invalidate()
                onFinish()
            }
        }
    }
}

#Preview {
    SplashScreen(onFinish: {})
}

