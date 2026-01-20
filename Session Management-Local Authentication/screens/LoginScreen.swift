//
//  ContentView.swift
//  Authentication Feature
//
//  Created by Nadira Seitkazy  on 14.01.2026.
//

import SwiftUI

struct LoginScreen: View {
    @Binding var path: NavigationPath 
    @State private var email: String? = nil
    @State private var password: String? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text(Strings.Login.title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
//                .padding()

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
                let emailValid = {
                    if let email = email {
                        return isValidEmail(email)
                    }
                    return false
                }()
                
                let passwordValid = {
                    if let password = password {
                        return !password.isEmpty && password.count >= 6
                    }
                    return false
                }()
                
                if emailValid && passwordValid {
                    path.append(AppRoute.home)
                } else {
                    print(Strings.Validation.validationFailed)
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
    }
}

func isValidEmail(_ email: String) -> Bool {
    let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
}

#Preview {
    RootView()
}
