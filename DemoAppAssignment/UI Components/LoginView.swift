import SwiftUI

struct LoginView: View {
    @State private var username: String = "test"
    @State private var password: String = "password"
    @State private var showContentView = false
    @State private var isLoggingIn = false

    var body: some View {
        ZStack {
            // Full-screen background color
            Color.green.opacity(0.1)
                .ignoresSafeArea() // Covers entire screen
            
            VStack {
                Text("Login to your account")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                TextField("Enter your username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 20)

                Button(action: loginUser) {
                    Text(isLoggingIn ? "Logging in..." : "Login")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                .disabled(isLoggingIn)
                .padding(.bottom, 20)
            }
            .padding(40)
        }
        .fullScreenCover(isPresented: $showContentView) {
            ContentView()
        }
    }
    
    private func loginUser() {
        isLoggingIn = true

        AuthService.shared.login() { result in
            isLoggingIn = false

            switch result {
            case .success:
                showContentView = true
            case .failure(let error):
                print("Error logging in: \(error.localizedDescription)")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
