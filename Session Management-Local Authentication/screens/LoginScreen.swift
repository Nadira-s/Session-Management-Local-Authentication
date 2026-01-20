//
//  ContentView.swift
//  Authentication Feature
//
//  Created by Nadira Seitkazy  on 14.01.2026.
//

import SwiftUI

struct LoginScreen: View {
    @Binding var path: NavigationPath
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var email: String? = nil
    @State private var password: String? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text(Strings.Login.title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)


            SimpleTextField(
                label: Strings.Login.email,
                text: Binding(
                       get: { email ?? "" },
                       set: { email = $0 }
                   ),
                placeholder: Strings.placeholder.emailLabel,
                validator: { text in
                    if text.isEmpty { return Strings.required }
                    if text.count < 3 { return Strings.Validation.emailError}
                    return nil
                }
            )
            
            SecurePasswordView(
                password: Binding(
                    get: { password ?? ""},
                    set: { password = $0 }
                ),
                validator: { text in
                    if text.isEmpty { return Strings.required }
                    if text.count < 6 { return Strings.Validation.passwordError }
                    return nil
                }
            )
            
            PrimaryButton(title: Strings.Login.title) {

               
                guard let email = email, isValidEmail(email),
                      let password = password, password.count >= 6 else {
                    alertMessage = Strings.Validation.validationFailed
                    showAlert = true
                    return
                }

                guard let savedUser = UserStorage.getUser() else {
                    alertMessage = "User does not exist"
                    showAlert = true
                    return
                }

                if savedUser.email == email && savedUser.password == password {
                    isLoggedIn = true
                } else {
                    alertMessage = "Invalid credentials"
                    showAlert = true
                }
            }

            HStack {
                Text(Strings.Login.text)
                    .foregroundColor(.gray)
                
                Button(Strings.SignUp.title) {
                    path.append(AppRoute.signup)
                }
                .foregroundColor(.blue)
                .bold()
                .padding(8)
            }        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
}

func isValidEmail(_ email: String) -> Bool {
    let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
}

#Preview {
    RootView()
}
