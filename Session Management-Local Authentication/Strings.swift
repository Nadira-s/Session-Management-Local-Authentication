//
//  Strings.swift
//  Authentication Feature
//
//  Created by Nadira Seitkazy  on 15.01.2026.
//

struct Strings {
    struct Login {
        static let title = "Login"
        static let email = "Email"
        static let password = "Password"
        static let forgotButton = "Forgot Password"
        static let text = "Don't have an account?"
    }
    struct SignUp {
        static let title = "Sign Up"
        static let name = "Name"
        static let email = "Email"
        static let password = "Password"
        static let confirm = "Confirm Password "
        static let text = "Already have an account?"
    }
    static let homeTitle = "Home Page"
    static let required = "Required"
    static let nul = ""
    static let emailContain = "@"
    
    struct Validation {
        static let nameError = "At least 3 characters"
        static let emailError = "Enter a valid email"
        static let passwordError = "Password must be at least 6 characters"
        static let confirmPasswordError = "Password do not match"
        static let confirm = "Please confirm your password"
        static let password = "Please enter your password"
        static let validationFailed = "Validation failed"
        static let invalidEmail = "Invalid email"
        
        
    }
    struct placeholder {
        static let confirmLabel = "Confirm your password"
        static let emailLabel = "Enter your email"
        static let passwordLabel = "Enter your password"
        static let nameLabel =  "Enter username"
        
    }
    struct UserDefaultsKeys {
        static let isLoggedIn = "isLoggedIn"
    }
}


