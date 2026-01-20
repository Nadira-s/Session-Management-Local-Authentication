
import SwiftUI
struct SimpleTextField: View {
    var label: String
    @Binding var text: String
    var placeholder: String = ""
    var validator: ((String) -> String?)?
    
    @State private var error: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(error == nil ? Color.gray.opacity(0.5) : Color.red, lineWidth: 1)
                )
                .onChange(of: text) { _ in
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
            error = validator(text)
        }
    }

    func validateManually() -> Bool {
        validate()
        return error == nil
    }
}
