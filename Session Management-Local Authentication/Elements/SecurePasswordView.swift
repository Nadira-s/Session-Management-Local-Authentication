import SwiftUI

struct SecurePasswordView: View {
    var label: String = Strings.Login.password
    @Binding var password: String
    var placeholder: String = Strings.required
    var validator: ((String) -> String?)?
    
    @State private var isSecured: Bool = true
    @State private var error: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                if isSecured {
                    SecureField(placeholder, text: $password)
                        .padding()
                } else {
                    TextField(placeholder, text: $password)
                        .padding()
                }
                
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: isSecured ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(error == nil ? Color.gray.opacity(0.5) : Color.red, lineWidth: 1)
            )
            .onChange(of: password) { _ in
                validate()
            }
            
            if let error = error {
                Text(error)
                    .font(.caption2)
                    .foregroundColor(.red)
            }
        }
    }
    
    func validate() {
        if let validator = validator {
            error = validator(password)
        }
    }
    
    func validateManually() -> Bool {
        validate()
        return error == nil
    }
}
