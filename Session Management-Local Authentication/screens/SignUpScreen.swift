//
//  SIgnUp.swift
//  Authentication Feature
//
//  Created by Nadira Seitkazy  on 14.01.2026.
//
import SwiftUI

struct  SignUpScreen: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @Binding var path: NavigationPath
    @State private var name: String? = nil
    @State private var email: String? = nil
    @State private var password: String? = nil
    @State private var confirmPassword: String? = nil
    
    @State private var nameError: String? = nil
    @State private var emailError: String? = nil
    @State private var passwordError: String? = nil
    @State private var confirmPasswordError: String? = nil
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View{
        
        VStack(spacing:20){
            Text(Strings.SignUp.title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
            
            
            SimpleTextField(
                label: Strings.SignUp.name,
                text: Binding(
                    get: {name ?? "" },
                    set: {name = $0}
                ),
                placeholder: Strings.placeholder.nameLabel,
                validator: { text in
                    if text.isEmpty { return Strings.required }
                    if text.count < 3 { return Strings.Validation.nameError }
                    return nil
                }
            )
            
            
            SimpleTextField(
                label: Strings.SignUp.email,
                text: Binding(
                    get: {email ?? "" },
                    set: {email = $0}
                ),
                placeholder: Strings.placeholder.emailLabel,
                validator: { text in
                    if text.isEmpty { return Strings.required }
                    if !text.contains(Strings.emailContain) { return Strings.Validation.invalidEmail }
                    return nil
                }
            )
            
            SecurePasswordView(
                label: Strings.SignUp.confirm,
                password: Binding(
                    get: {password ?? "" },
                    set: {password = $0}
                ),
                placeholder:Strings.placeholder.passwordLabel ,
                validator: { text in
                    if text.isEmpty { return Strings.Validation.password
                    }
                    if text != password { return Strings.Validation.confirmPasswordError }
                    return nil
                }
            )
            SecurePasswordView(
                label: Strings.SignUp.confirm,
                password: Binding(
                    get: {confirmPassword ?? "" },
                    set: {confirmPassword = $0}
                ),
                placeholder:Strings.placeholder.confirmLabel ,
                validator: { text in
                    if text.isEmpty { return Strings.Validation.confirm}
                    if text != password { return Strings.Validation.confirmPasswordError }
                    return nil
                }
            )
            
            PrimaryButton(title: Strings.SignUp.title) {
                let usernameValid = {
                    if let name = name {
                        return !name.isEmpty && name.count >= 3
                    }
                    return false
                }()
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
                
                let confirmValid = {
                    if let confirm = confirmPassword, let pass = password {
                        return !confirm.isEmpty && confirm == pass
                    }
                    return false
                }()
                
                guard
                    let name = name,
                    let email = email,
                    let password = password
                else { return }
                
                if UserStorage.getUser() != nil {
                    alertMessage = "User already exists"
                    showAlert = true
                    return
                }
                
                let user = User(name: name, email: email, password: password)
                UserStorage.save(user: user)
                
                isLoggedIn = true
            }
            HStack {
                Text(Strings.SignUp.text)
                    .foregroundColor(.gray)
                
                Button(Strings.Login.title) {
                    path.append(AppRoute.login)
                }
                .foregroundColor(.blue)
                .bold()
                .padding(8)
            }
        }
        
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}


#Preview {
    RootView()
}
